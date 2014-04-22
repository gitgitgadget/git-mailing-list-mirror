From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 23:41:44 -0700
Message-ID: <53560F28.9020904@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 08:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUOz-0006Hk-MS
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaDVGlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:41:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:59151 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaDVGlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:41:51 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4465167pdj.8
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GKMFHeEGmeeZgukcuvPgf4N/MSEGwMvaJcJNraXBV5c=;
        b=vG9atM7N1rusDbP1C1WnHV3JkKicFANyFU1yJCG4iYzs6E+T4FKLfD0JfG0YrPp7CJ
         FQfTi1P4Us9KvKL9Yy5vTYTz7PqeMniG6OzTXnNXgq3vRGJNO/lWWKxZ4M4Qs5G2JHVo
         QulneCT5Fj1kZhg3Mjg8Abv7rZjuUO8x/Zr7w9dLycA3aLC866g5mUtxX1E+fSNIT5Gk
         8FPrPKztHiyGZmQNZGCRiUPSNpIf/roo5NzN6kdDasse33K6bJBlB6JidGnKg3wk6RCM
         QzRISHGQE7I33lCYYQ7ebDOgtvutGpnUdr1zNUCrNAeB3sfzPmw7ZMTYevMbJjkC3IT5
         hVSQ==
X-Received: by 10.66.219.6 with SMTP id pk6mr42709565pac.9.1398148911146;
        Mon, 21 Apr 2014 23:41:51 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id de5sm82446144pbc.66.2014.04.21.23.41.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 23:41:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <53558476703cb_5c94d452ec4e@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246701>

On 4/21/2014 1:49 PM, Felipe Contreras wrote:
> Ilya Bobyr wrote:
>> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
>>> This hook is invoked whenever a branch is updated, either when a branch
>>> is created or updated with 'git branch', or when it's rebased with 'git
>>> rebase'. It receives two parameters; the name of the branch, and the
>>> SHA-1 of the latest commit, additionally, if there was a base commit the
>>> branch was rebased onto, a third parameter contains it.
>> And the old branch SHA could be found from in the reflog, correct?
> Actually the old branch SHA-1 is actually the current one, since the branch
> hasn't been updated at that point. Personally I don't see much value in adding
> something the script can easily find out.

If the hook is about a branch update, I would expect it to provide both
old and new points for the branch, along with the name.

The fact that for rebases it also provides new base SHA is very
convenient.  As it is an optional argument it may make further extension
of the interface a bit awkward.
So, is seems reasonable to provide both from the very beginning.
I was looking for hooks like that, to maintain certain meta-data about
the branches.
Old SHA would be very useful in that case.

I am not sure if both SHAs are easily available at the point where the
hook is called.
