From: Dmitry Gutov <dgutov@yandex.ru>
Subject: Re: 'git diff-index' doesn't honor the 'diff.algorithm' variable
Date: Sun, 15 May 2016 23:36:10 +0300
Message-ID: <c81e4b71-29f2-6a11-7bf4-769013d34a6d@yandex.ru>
References: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru>
 <xmqqshxk7aa8.fsf@gitster.mtv.corp.google.com>
 <8e5a7045-77f7-acb0-de7f-3e8f72479ec3@yandex.ru>
 <xmqqwpmv5fi3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b22lw-00055F-A1
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 22:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbcEOUgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 16:36:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34484 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcEOUgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 16:36:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so14104798wmn.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rOrqgsuIbVVukdkzRJ8R79q92AABoBkMGARRdgO19vg=;
        b=K44MbOO38OyB2GmLsBclcBARBy6CElc2mF95wLwYkOBgeSt6JkkZxd7tFxYqSo7qm+
         b6awkpHVFwlmNEauPCmvM82MfsVb7XrlhWXWqi126xcYCZ8M7g/2vSwWJnOhH+X+v4D5
         Rm2EAQkBHw37K4o8Dk+nFX5rX6w+xP0VTRXBqmn92QXMn1fqM1mrNJ398xW+MWz7iEbW
         YyAmjpA2FMs5dBeEy5i0fr5IwnASO0HEVyWaDv6sczX/HA5+gW3Jk49ocTkuJeDjh2zJ
         XVk1NltUNtMpoCNQ90o64rFy1JRJhaHIogHW48HtmdnRVqX2zwINuHtrx6NehcAp0/HC
         9JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rOrqgsuIbVVukdkzRJ8R79q92AABoBkMGARRdgO19vg=;
        b=j4Gw/h+VQ8OuQv+kKEMmDDoIElBO5p7Q60Ac1/TJ/MT2+Ya54wCJ6T+sbq1TMlHIo0
         1D2QWNzgzEJFW3IsRs5ojJCr6KJ16e6TvYqPd97Vnfyr2L6dkG9Ue5sO1hqjdjP1F+WN
         fIvN2apPJsuVtvq/bttDSdh5jBLN1y17FJBI/UO7ieXdf63X72A/NdI13+BWY0tV8rFb
         wTo66bQ0rtH+fklZUf21TcRU1dMCRgFzk8YzPpp8Ef50mKmYFDY5CzhcIFh6sC7d7anl
         6FkTXu4E8ZG8JwpAxfLCpkjH/zDwAWmKDOwwKnBiafn7fqYhjqzIVoM+BoMNFM0Jx6ke
         vj3A==
X-Gm-Message-State: AOPr4FWZgdbcm1bqGrT0tQlAfz2+vv9Gxd6QIxA6fIxmnJPdbPbCpMDDrU5tyXMmrLuG7g==
X-Received: by 10.28.142.137 with SMTP id q131mr13131993wmd.81.1463344573212;
        Sun, 15 May 2016 13:36:13 -0700 (PDT)
Received: from [192.168.1.2] ([185.105.175.24])
        by smtp.googlemail.com with ESMTPSA id u4sm30131238wjz.4.2016.05.15.13.36.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2016 13:36:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1
In-Reply-To: <xmqqwpmv5fi3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294684>

On 05/15/2016 09:43 PM, Junio C Hamano wrote:

> I think the paragraph is shared among the "diff" family of
> commands both plumbing and Porcelain, so I'd say "patches welcome"
> at this point ;-).

I think I've done my part here. It's not like this is a feature request.

> The script was an illustration of the logic--I am sure elisp is much
> core capable scripting environment than POSIX shell.  Perhaps (setq
> vc-diff-git-diff-use-histogram t) in ~/.emacs is not too bad ;-)

Yes, doing it via a user option is already possible in Emacs. I was 
concerned that the user has to configure it twice (once for console, two 
for Emacs), but if you think it's fine, let's leave it at that.

> The Porcelain "git diff" command is not bound by any promise of
> stable output and reserves the right to change the default to better
> support human users.  I think the upcoming version of Git turns the
> diff.renames setting on by default, for example.  We might even add
> a side-by-side diff and make it the default someday.  You do not
> want to be reading these "fancy" output, and you cannot keep
> updating the invocation of "git diff" by vc-diff with unbounded
> number options, e.g. --no-side-by-side, that will be added to defeat
> configuration variables that will be invented in the future.

Fair enough.

Thanks,
Dmitry.
