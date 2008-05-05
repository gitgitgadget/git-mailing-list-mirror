From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 5 May 2008 20:10:11 +0800
Message-ID: <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 05 14:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszX4-0002N4-4B
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYEEMKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYEEMKO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:10:14 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:48916 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYEEMKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:10:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so536041and.103
        for <git@vger.kernel.org>; Mon, 05 May 2008 05:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vC0lxxvbEMd6k6caeaE09/I4fOx+H7bTw1NbQnRNGKQ=;
        b=MzApMfT5Fa1EIj8jqoGb4gVyjU5+ugV3xR6Byfvl2lYcD7PbP3Mak6QMbhFOKN1GhIaSmpz10QL0XR0ttA0qH/jB37T3nSN4lkL+Nrnu2JvvdzuF262Ud0bs5NwCb6DWwGwzEvs8Pjl6paSszpUFMbAtCBCoYD6fOxS/84e5CRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tOEnezSXO5PZxcf3z+bCMGEa1FPcNz8iWjx37eKxr/CMi6fTR6IAbgfK1w2wUPyQcCxBicLrglkEvokqAZuVw7Tnnr/FxNN5507zQa9g2i9CIHZvnu2msEB1NY0DDZWttoezVo46xApa11Tey81IU9urIedoHm/sVhGJgEYZj60=
Received: by 10.100.213.4 with SMTP id l4mr7438633ang.53.1209989411363;
        Mon, 05 May 2008 05:10:11 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 5 May 2008 05:10:11 -0700 (PDT)
In-Reply-To: <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81273>

On Mon, May 5, 2008 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > For this example,both "/if/while/ (i />/>=/ /1/0/)" and  "/if/while/
>  > (i >//=/ /1/0/)" are fine to me.
>
>  For the particular example, both are Ok, but for this other example:
>
>         -if (i > 1...
>         +if ((i > 1...
>
>  it probably is better to treat each non-word character as a separate
>  token, that is, it would be easier to read if we said "( stayed intact,
>  and another ( was added", instead of saying "( is changed to ((".
>
>  So "a run of punct chars" rule only sometimes produces better output but
>  otherwise worse output, and to make it produce better output consistently,
>  we would need to know the syntax of the target language for tokenization,
>  i.e. ">=" and ">" are comparison operators, while "(" is a token and "(("
>  is better split into two open-paren tokens.
>
>  So as a very longer term subproject, we may want to teach the mechanism
>  language specific tokenization rules, just like we can specify the hunk
>  header pattern via gitattributes(5) to the diff output layer.
>
>  Of course, I do not expect you to do that during this round --- and if we
>  choose to keep the rule simple, I think it is probably better to use
>  one-char-one-token rule for now.
>
>
>  > And when designing, i think it's better to take multi-byte characters
>  > into account. For multi-byte characters (especially CJK), every
>  > character should be considered as a token.
>
>  If we take an idealistic view for the longer term, we should be tokenizing
>  even CJK sensibly, but unlike Occidental scripts, we cannot even use
>  inter-word spacing for tokenizing hint, so unless we are willing to learn
>  morphological analysis (which we are not for now), the best we can do is
>  to use one-char-one-token rule.
>
>         Side Note.  For Japanese we could cheat and often do a slightly
>         better job than simple one-char-one-token without having full
>         morphological analysis by splicing between Kanji and Kana
>         boundaries, but I'd prefer not to go there and keep the rules we
>         would use to the minimum.
>
>  I should stress that I said "character" in the above "punct" and "CJK"
>  discussions, not "byte".
>

The one-char-one-token and multi-char-one-token rules may have
different implementation issues. I think multi-char-one-token rule may
be more representative. So for the current time, i prefer considering
both run of word characters and single non-word character as a token.



-- 
Ping Yin
