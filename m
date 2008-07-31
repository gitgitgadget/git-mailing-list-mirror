From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 23:51:43 +0200
Message-ID: <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOg50-0003vm-8y
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759219AbYGaVvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759212AbYGaVvp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:51:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:54957 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203AbYGaVvn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:51:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so999575wfd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xWXovSnQRxZOeKaHMXcOcEuOjna/EZhh/gCzeMT4ZCA=;
        b=iiEc9b9IAGew55C7D74ddxoSpHjpOvghz5ganksy9yAqikTMfBcbNMtldYbf7QbCss
         wu3OHYClDM7G3//eh1ijcun/BQWrgibtg7rn2WVnc736UJJ5QsuJH8v+qGOlc6/PC/6G
         iYncfT2/XRbs+fAGMLczJTVLyAT1fbZphftFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=MC9ZNKJJ9Wr7IKuFopode7Nt6g72DaiVK9Iw6j0vf/ypoJZCdV4te3en5LNE9hxjSD
         JBh5OV/WJrcUtW972dsBRmbiGuXFcHPQCAASpaCwW4X75/G8Hp2f9gEkIZ4jEhAkwsPX
         SjQAoKBWB69xhjcFmN82cZ9OoUvuBNcZ8FRUA=
Received: by 10.142.162.9 with SMTP id k9mr3446185wfe.211.1217541103135;
        Thu, 31 Jul 2008 14:51:43 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Thu, 31 Jul 2008 14:51:43 -0700 (PDT)
In-Reply-To: <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91002>

On Thu, Jul 31, 2008 at 23:44, cte <cestreich@gmail.com> wrote:
> Using output from the command line utilities as an API has its own set
> of problems. For instance, check out some of the difficulties that
> gitk and qgit have had to deal with:
> http://kerneltrap.org/mailarchive/git/2007/11/2/379067.

I beg to differ. If I skimmed the topic correctly, the problems there
were not related to having to parse git's output, but due to the fact
that '--topo-order' is a post-processing operation, which takes long.
Do read the recent discussion between Linus and Roman about that.

> Digging into
> the git internals and reusing its core functions will always be more
> powerful and flexible than parsing command line output.

Sure, but is it worth it? What do you need in your GUI that you cannot
get from the plumbing?

> Of course, it
> is not always easy; git wasn't written to be easily compiled into a
> library and reused (graceful error handling and memory management are
> problematic). But I think the right thing to do is to work towards
> making the awesome git internals easier to use for other developers so
> great tools can continue to be built on top of git.

I do agree with that, libification of git would be really nice.
Especially since that'd mean that integrating it into other languages
(by means of wrappers), such as Python or Ruby, becomes a lot easier.

>> There is, use the plumbing, forward compatibility is 95% assured. With
>> the exception of major releases, for which any plumbing
>> output/behavior changes will be announced in the changelog, usually
>> including an explanation on how to change your code to match.
>
> 95% assured != correct, IMO :)

Why not? Junio has a very good reputation of keeping git backwards
compatible. The 95% is of course not an actual figure but an
expression meant to indicate "statement is true, minus a few rare case
exceptions".

>> In short, use the forc-... errr, plumbing ;).
>>
>> --
>> Cheers,
>>
>> Sverre Rabbelier
>>

It's ok to remove text that you do not respond to, including signatures :P.

-- 
Cheers,

Sverre Rabbelier
