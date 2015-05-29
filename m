From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Fri, 29 May 2015 18:25:29 -0400
Message-ID: <CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	<xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
	<CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
	<xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 00:25:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YySic-0004Jm-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbbE2WZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 18:25:31 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33922 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030AbbE2WZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 18:25:30 -0400
Received: by ieczm2 with SMTP id zm2so73498140iec.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G1Ee/fpar0Q/lB/EWWEbUytilTSEN7zGcHPyTh7NfFs=;
        b=hHmMlbbJ2laxDpHF3XafSziq2Z5gqltX4lnWwEfvFgbbKXPquF6QowMKWoETKNCgCA
         HmTwTVBmAI0wqP+dPWmdVyn7Yn6pSvRQrOG9UK8Z5rZNPrlOhc/C77ecKlAAaF7RQ+X7
         ok1t7rqsn8oghhF9kjv8D06izPcOmQpQ+Cs+WkAg8AYBqNwYK1k7KdP6u6BdgRY84M6l
         6L8LmOyrPfAc1Y3RRg9egARzzx/IGiGenMdI/WWCYZpVlQcGdDAATIUuE4FiRAZoHNFO
         Iq2EARrbw8ho/DuM0T3xesZNyXpUmDS85PqDsrTIitAmWkHC4szHKf+X3usjyTl+d1QR
         uWDg==
X-Received: by 10.43.135.5 with SMTP id ie5mr17842854icc.78.1432938329448;
 Fri, 29 May 2015 15:25:29 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 29 May 2015 15:25:29 -0700 (PDT)
In-Reply-To: <xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: TTsgYoim9aVEvPAxbvda_QddO34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270277>

On Fri, May 29, 2015 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> By default, we should run clean-up after the editor we spawned gives
> us the edited result.  Not adding one more LF after the template
> when it already ends with LF would not hurt, but an extra blank
> after the template material does not hurt, either, so I am honestly
> indifferent.

I had a similar reaction. The one salient bit I picked up was that
Patryk finds it aesthetically offensive[1] when the template ends with
a comment line, and that comment line does not flow directly into the
comment lines provided by --status. That is:

    Template line 1
    # Template line 2

    # Please enter the commit message...
    # with '#' will be ignored...

[1]: Quoting from the commit message of patch 1/2: "...which is very
annoying when template ends with line starting with '#'"

> If the user specified with the --cleanup option not to
> clean-up the result coming back from the editor, then the commented
> material needs to be removed in the editor by the user *anyway*, so
> one more LF would not make that much of a difference in that case,
> either.
