From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 1 Aug 2008 10:11:16 +0200
Message-ID: <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 10:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpkK-0007qH-Oi
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 10:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYHAILU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 04:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYHAILU
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 04:11:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:16523 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYHAILR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 04:11:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so550445ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ckqCG02dpfIeM+jYI6fq0wZwfCETxSokAyuWm9idC5E=;
        b=JfEBDhrCfloqDNHn2XOZxSApz551/UIuobbmqiKAHR3Ti0wRFv9DVN/haBplSsTojw
         ooPBopOY42Y0z4faPEzOlN8SmY4UBHU2OR++LRt+syCtUAX4RPhrc+DnmcSd4S1I3nC/
         rNHHrbeXho4VUrmTwtXD6acdFlgdcSSxMXIUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XPNXrjuoGFfsix9ot+h6s0h3ZzYli9Bk9ivpLzSohgtNHuttWVgXjp7KgYWtLTAaWw
         aQ60klfoPK8DsH4K31QhXsBJazNOc7H65krSVEv/Q+at17CGI1EmlS3vqU7wgPVYpWqv
         6GvYIdFb29PQJvWY0YtwSRY/TQfJRbU+Tm/l0=
Received: by 10.150.202.8 with SMTP id z8mr2775481ybf.34.1217578276992;
        Fri, 01 Aug 2008 01:11:16 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 1 Aug 2008 01:11:16 -0700 (PDT)
In-Reply-To: <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91042>

On Fri, Aug 1, 2008 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
>
> I do not talk Ruby,

You're really missing into something ;)

> so I'll wait for a few days to hear any one of the
> following happen before deciding what to do with this patch:
>
>  (1) Yeah, this is a sufficient and necessary set of keywords, and it
>     would make my Ruby life so much better;
>
>  (2) This might be a good start but you need to cover this and that
>     keywords as well;
>
>  (3) This will misidentify a line that is not the beginning of a
>     definition, and should not be applied;
>
> Needless to say, "Here is a better patch" is appreciated if somebody says
> (2) or (3).

I wasn't sure about the completeness of the regexp myself, which is
why I asked in #ruby on freenode for additional suggestions. The only
reply I got was an idea to add a number of block-based coding sections
such as Procs an Threads by matching .*\.new ({|do) as well.

This is something I had been thinking about myself, but I decided to
discard the idea because the current chunk text detection in git does
not have a way to say 'this is the end of a function, so get back to
the previous chunk (con)text' instead of using the last chunk text: so
if I have methodx followed by methody and make a change near the top
of methody I get methodx in the chunk text.

This limitation, that affects all funcname parsers, has kept me from
adding Proc, Thread and other anonymous code blocks to the Ruby
funcname, because having the proper context for changed code after an
anonymous block is IMO better than having specific context in the
anonymous block itself.

OTOH, if the funcname capability was expand to a full stack
manipulation (push chunk text, pop chunk text) ... (and yes, if I ever
find a sane way to do it myself I *will* provide a patch)




-- 
Giuseppe "Oblomov" Bilotta
