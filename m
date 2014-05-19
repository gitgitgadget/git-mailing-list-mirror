From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 03/31] refs.c: rename the transaction functions
Date: Mon, 19 May 2014 16:11:37 -0700
Message-ID: <CAL=YDW==tVrtonoDmBrucWgnTGbqEs70tq5zCp6xjDPgg4G16A@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-4-git-send-email-sahlberg@google.com>
	<xmqq38g9a0i0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 01:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWic-0008G4-PS
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaESXLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:11:39 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:43854 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaESXLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:11:38 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so7200223veb.39
        for <git@vger.kernel.org>; Mon, 19 May 2014 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NzcDwDvZwgkgFNB2WL2d3FQsUDiHJ9Rr/LKFP7f4VKQ=;
        b=ScLDBmxLx7O2mEXgb1NU5IHd+tSqZ8175L56i6fKizkGkN20Lt/ijhi7TGHSqwUHjC
         FWiaFb2aEABAuO6UD2pdykWqebaU26BIodEVNfsBc5Sab8U2P5nOxAB5zp2JmoUCVKUg
         NPxmqIR/8f59hQFI+DauLR0YdQaL9HuluC0wK1GFCxDET46MSTvpCbC08lbChyzM+aZY
         X2E2pU2/xFqRAt68g2aAB9K0iPFMbffwRGRmv6Ey8FJZ4rfhszk6mKPiL7d3lwQuoLGl
         Py9Cg3qbs+Loi2tOlFUmQA3O0PGh3KB//sdhL/Ix6WTPRYWROoUsjJYd6WIb8y/90wpU
         WVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NzcDwDvZwgkgFNB2WL2d3FQsUDiHJ9Rr/LKFP7f4VKQ=;
        b=KbNeK/SRWWk6E9JG4J6mhkra0y62DsxxDcVGAclj9rm7n2mNdWTFdaCGRpiZUUsLYw
         9l/e8WrkwNwjhsL6erk9wnaN3LvaIO90FJU/Mt3eyKHuV26d64fudhFxiUov3VyeZ/S2
         ++Z67f4nmPfRrQxpwuDVGEQ98iC/gb4NNZlSAY1DJUWlTf/3WD4/sQYarijimYSWCsrb
         GrD3rCA2y5se5227UA5/iX0MU+7SeR4vPJ6up+M55e9uECezVtv05/z7bPZ28fXZ8Df9
         axeYb/ay3iiq863OiSm1OKYkgL0oJOAOlYrr6igDmycd+OtfuofJt6IQq0cFF38Aznjm
         UH2g==
X-Gm-Message-State: ALoCoQk6LR7nJcSFMYdKavuY2SeIZ8FdiGsun6FuhKVFAFLtdGDjINfQ2NxiDUTXen2CO+eyo4Ez
X-Received: by 10.53.13.133 with SMTP id ey5mr588606vdd.8.1400541097440; Mon,
 19 May 2014 16:11:37 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 16:11:37 -0700 (PDT)
In-Reply-To: <xmqq38g9a0i0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249635>

On Fri, May 16, 2014 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Rename the transaction functions. Remove the leading ref_ from the names
>> and append _sha1 to the names for functions that create/delete/update sha1
>> refs.
>> ...
>> -             transaction = ref_transaction_begin();
>> +             transaction = transaction_begin();
>
> Why?  Do we forsee that there will never be other kinds of
> transaction, and whenever we say a "transaction" that will be always
> about updating the refs and nothing else?

ref_transaction_... is a bit of a mouthful.
I think initially we will only need a transaction framework for normal
sha1 refs, for symrefs and for reflog updates and these should all be
handled by the same transaction system so a single
_begin/_update*/_commit should be able to atomically commit changes
that involve updates to all three types.

I am not sure if we need transactions for other types of data, such as
sha1 objects, but if it turns out we do in the future we can rename
these functions again.
