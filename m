From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Wed, 7 Jan 2015 13:34:23 -0600
Message-ID: <CAEtYS8SiP8bU=82H+XxXZqa47hQ7hOAsZChCr94DwgPNft9L=g@mail.gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
	<xmqqiogu1n06.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 20:35:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wNC-0006GV-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 20:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbbAGTe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 14:34:26 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46353 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbAGTeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 14:34:25 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so1651587lbv.7
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bcK5W1gVcJG5dejoKLlQPpUgiQg6PWemEgk/vqcuolw=;
        b=muj5tb8zH/RAW7ugYRgT6xC3lr+PvtFcz5/RwtWIYFoi22heA4NBO7WQ0IcOqk7d1D
         gh3OdstnWpWFDAVe6aVu/1uujiWm3FWUK4vMV0icNQWD5ZmIVGSXdtwGno7V5qSJ3M8c
         HvYVRmm4EjzrxVkhEiwyURER/5U5pvvvZPLASEqbpccrlVaNpYlMRJtFkB6bHd7/AV9x
         QRyVFPTnHjDS8cunSnUhtQfbkGE3M98NVgJfnAmbCPeJ5EaUV4ZErcecuEtrrqQH48o5
         ezbel0huVU44p7q3ga76uYkqbNM/+7UO58oPE8gehyAbgdGBvJEWCor87sKavzvv+x0v
         zatA==
X-Received: by 10.152.204.70 with SMTP id kw6mr7608303lac.53.1420659263746;
 Wed, 07 Jan 2015 11:34:23 -0800 (PST)
Received: by 10.25.23.139 with HTTP; Wed, 7 Jan 2015 11:34:23 -0800 (PST)
In-Reply-To: <xmqqiogu1n06.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262147>

On Mon, Dec 29, 2014 at 9:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       (git am --abort || true) &&
>
> Why (x || y)?  Is 'x' so unreliable that we do not know how should exit?
> Should this be "test_must_fail git am --abort"?
>
Updated to test_might_fail -- we don't know if a merge is in progress or not.
We still need to clean up, but disregard failure if a merge isn't in progress.

>>> +       (cd submodule && git rev-parse HEAD >../actual) &&
>
> "git -C submodule rev-parse HEAD >actual" perhaps?
>
Seems sane to me.

>>> +test_expect_success 'diff.submodule unset' '
>>> +       (git config --unset diff.submodule || true) &&
>
> I think test_config and test_unconfig were invented for things like
> this (same for all the other use of "git config").
Yep, much nicer. :) Also updated to test_commit as suggested by Eric.

Thanks!

--Doug
