From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Sun, 4 May 2008 08:32:54 +0800
Message-ID: <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 02:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsSB3-0000rH-41
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 02:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbYEDAc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYEDAc4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 20:32:56 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:28709 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYEDAc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 20:32:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so435330and.103
        for <git@vger.kernel.org>; Sat, 03 May 2008 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XL09QByW2lWgh73e5guzIOM7pjQ0YlcgqqHqitGzpUs=;
        b=RHZAkpHrg4tPzwWDzYyWlup4NbvgMG2ayDxsAMOCuhE84+UxgZMrxZlEEtMvcYWfBzUfuXU1mlu1ucdTM3COM68e7VBCZWmC04G77U3AsUrZp7BF7seEdYuNX6gupiCLFu+FieBj8zFo4PxeROjoCF7zwSFduNpK2GQUriUAL9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GGfagXzlB9/buRLPFVmCsZYOzK5hDnfiQ1b3mqF7FIOyTH7ue3R6kDQJF2w/nRnrrmi5BpGtxb9Dm1Zm+pD5kiqIPy095gLAwB3XE+ZG2qbgDgMZg1ZZE+BeDhKrLsjOUloH95JxsWL9/tIWZ60r90LHnsmk5q81X5bMI2nRsVk=
Received: by 10.100.166.9 with SMTP id o9mr6327097ane.120.1209861175059;
        Sat, 03 May 2008 17:32:55 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 3 May 2008 17:32:54 -0700 (PDT)
In-Reply-To: <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81123>

On Sun, May 4, 2008 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Has this series been ever tested?
>
>  $ git diff one two
>  diff --git a/one b/two
>  index f9facd3..10c6195 100644
>  --- a/one
>  +++ b/two
>  @@ -1 +1 @@
>  -A quick(brown) fox
>  +A quick(yellow) fox
>
>  $ tail -n 2 .git/config
>  [diff]
>         nonwordchars = "()"
>
>  $ git diff --color-words one two
>  diff --git a/one b/two
>  index f9facd3..10c6195 100644
>  --- a/one
>  +++ b/two
>  @@ -1 +1 @@
>  A quick(<red>brown)</red><green>yellow)</green> fox

Yeah, i tested it. It's a better improvement, although not the best.
As i said in the commit msg

If we set diff.nonwordchars to "()", the example above will show as
"if (<r>foo(</r><g>bar(</g>arg))". It's much better, athough not the best.

As you said in another thread, unless we insert LF between run of word
chars and run of nonword chars, the is no way to achieve the best
result.

I have try my best to achieve a better output in current
implementation (say, replace nonword chars with LF)



-- 
Ping Yin
