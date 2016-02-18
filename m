From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv12 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 15:14:06 -0800
Message-ID: <CAGZ79kZwgBJQ2bkvKSuT+ULiSPL9x5WTcwVJG0FATNv-D_-AhQ@mail.gmail.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
	<xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:14:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXm1-0004LE-FA
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947624AbcBRXOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:14:09 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:35252 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946276AbcBRXOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:14:07 -0500
Received: by mail-io0-f181.google.com with SMTP id g203so91256322iof.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=En3KCdNSdTlz2t5Vviiiaef6OF7HunakrZel10jUatw=;
        b=YV99NYMvfXuQLXqFGnsp6GOkhob/I8kSiOqcsgVReZsCpDFffzv7lGNjM1xn1YJ+HX
         Ue4LBQVDreHIdvKZqqBuBn7OOHrhlndR5iV5ao/CW7zGpHIuJsnYRDGJbAcKhn/WAa5O
         ELIHp7JuKXOddW7eP8AQ7QAAwOPII2AjCJ9SIWU3Yy0zOR8zMtqB/quJhc3ABmfMLN5w
         WFCQCEEdIm/xK7qaK9xnR7AN/9VJFIQ0vl2yH68B7iGYyddo4x5ylla9D6qnBF7V7WDC
         dXGnxLz8E2itJ0m6EqTntV1usyT9lazTaLEWaAB6n6ybw/TRDsaA0UQwfYYY0+OGpZzX
         gDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=En3KCdNSdTlz2t5Vviiiaef6OF7HunakrZel10jUatw=;
        b=Bgf2OYiCFR4CT1DLt4kIsfmfmMnNSEw558vJSeiL3fZNW3GEZNhCS2PLCOhxtuq2KO
         Mcgygvm0FK0b5GRY8pRQ1uVqT85FOmePtXd76WVhVPy9DJ0mu8wsXDc96+B97olnKhQx
         6YWJhJ147qLnPGZo+HagPJHaM4vlkGhIk1ZtkK9Ursh3HObxSO2PJHVsCjvicyTagiRy
         NDLQG+z8JcTGeVihAh82xO0mLXpDSvIhsMhH5mxpUvZTwH/N3yOhwOJvUo6gRmR8UUDI
         sl4n3LMF4ZjrgXak7QYe2/ty02u+Yh7AjLDpCpxdCDNq0I69pbdAhp9OS9I+rzSZljzv
         no6w==
X-Gm-Message-State: AG10YOQuxXdc4ND8LMYlOwBjlEpi9z6V7E6n+Ab2/Ls3+xF/B+gZlTCg/llO3z4IWQY/1sIKYT1NpIQJ7Cl2lCAW
X-Received: by 10.107.158.81 with SMTP id h78mr11314281ioe.174.1455837246954;
 Thu, 18 Feb 2016 15:14:06 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 18 Feb 2016 15:14:06 -0800 (PST)
In-Reply-To: <CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286639>

On Thu, Feb 18, 2016 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>> Unless you count "I want to write differently from what was
>> suggested" is a desirable thing to do, I do not see a point in
>> favouring the above that uses an extra variable and skip_prefix()
>> over what I gave you as "how about" patch.  But whatever.
>
> The skip_prefix was there before, so it stuck there.
> Also it seems a bit more high level to me hence easier to read,
> (though I am biased). I'll use your suggestion.

and it doesn't crash when passing in value == NULL.
(We don't do that currently, just a side observation)
