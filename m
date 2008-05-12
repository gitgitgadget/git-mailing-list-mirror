From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 12 May 2008 21:57:55 +0200
Message-ID: <200805122157.57366.jnareb@gmail.com>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com> <m34p934afu.fsf@localhost.localdomain> <7vve1jxrg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Ping Yin" <pkufranky@gmail.com>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 21:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveAm-0008GX-Rd
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbYELT6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYELT6K
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:58:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:58149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYELT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:58:09 -0400
Received: by ug-out-1314.google.com with SMTP id h2so758575ugf.16
        for <git@vger.kernel.org>; Mon, 12 May 2008 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=POGRTBdc/JQ9AMRBCsNUdwR268swJvISNzT99J3sRdU=;
        b=DQled27lis5msOQxpHYlXXvkc07RG9P4j2HQw2CCB+9xe0ZLhwkU5X6naoq8duIL+4nOKtxCgZfWkdwpoJSHXvWkYUTsC4OpSV7rzINuhFK7HANpMF2K6r0pKEflpF4qarMLz6CRiMV5LO06E92Cvdy5O4xN8AKf2IDwfi+Wmr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YkdUDh8uK+5I0TGZ7K9PQEYVfkWT2Gn5aHGxN15rH5a2vvH2m+IsYOapOcrwWLLAwAq/IXCPhwugSr+Mx/sds4eABKDwYSrATGslxyFXxWHAInE7EJi6IhR505h8b1EZ223FlMGBROWAd2p6NraWJ8EdglgQ8cgYdH6lLKQiu0I=
Received: by 10.67.98.15 with SMTP id a15mr6048530ugm.32.1210622287766;
        Mon, 12 May 2008 12:58:07 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.115])
        by mx.google.com with ESMTPS id g11sm16262736gve.8.2008.05.12.12.58.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 12:58:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vve1jxrg9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81916>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> "Ping Yin" <pkufranky@gmail.com> writes:
>>>
>>> To achieve the best, we have to find the pairs of lines (one minus and
>>> one plus for each pair) which most match each other, and then do the
>>> word diff for each pair.
>>
>> Wouldn't be enough to treat run of plus/minus lines as a single block,
>> tokenize, do token-based (as opposed to line-based) diff, then show it
>> using linebreaks of the destination file (pluses line)?
> 
> I tried the "using linebreaks" but I discarded it because I did not think
> it would work.  If we rewrite the last three lines above with this single
> line:
> 
>> Wouldn't be enough to use magic?
> 
> and apply that algorithm between the two, then we would get a long single
> line that has words painted in red, two lines worth, followed by green "to
> use magic?"  and finally an end-of-line.

It looks then like inserting (retaining?) newlines in word/token based
--color-words output isn't simple.  It would have to produce readable
output both for the case you stated/mentioned, and for the opposite case
(replacing single line by multiple lines).  What's even more difficult,
it should produce clear output for a simple case of rewrapping output,
e.g. the following as replacement.

>> Wouldn't be enough to treat run of plus/minus lines as a single
>> block, tokenize, do token-based (as opposed to line-based) diff,
>> then show it using linebreaks of the destination file (pluses
>> line)? 

Gaahh... I don't think this (word diff/token diff) is something computer
science has worked on?
-- 
Jakub Narebski
Poland
