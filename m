From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 20:19:49 +0100
Message-ID: <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net> <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net> <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com> <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cCG-0008KY-5G
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbaAGTUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:20:12 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:56037 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaAGTUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:20:09 -0500
Received: by mail-oa0-f44.google.com with SMTP id h16so679236oag.17
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cPZm1UTsVIBGDh9o2nveqTUDgXVcM/3Vvq9+fuYvlvw=;
        b=R84Z4tPBMjhsJAqb8+4IzyuYaXQIvl1/ZD8Yt4ETCjjOZ+yJewSIfl1Tda7LMxzYP7
         hcNAQmCGQwht3DtPv2CnGOdJcpDDCZOAb9/1ucc7Pz/cLwc2RBBJZTE1q85jO860sHTQ
         EyMsCgNcrKVnDmF8FvuyEQLK2GlZjiLFM/TOyyKkDcQaxVPOsJa5166jtADSKZm+8fc2
         dsk3IeRVM1k0ieUCe2drWWxccpkytkoXOB/loJZ2r3vdxNPxBxOAXPik8z94tQO+wisR
         V9XcOt+jATcX57t5wgwPrHnpC6bJ/rgDrNv4ofrPNtaTYGwuJFMeEr07/FajYRSb7Ioc
         O8CA==
X-Received: by 10.182.92.231 with SMTP id cp7mr1034082obb.82.1389122409157;
 Tue, 07 Jan 2014 11:20:09 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 11:19:49 -0800 (PST)
In-Reply-To: <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240130>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
>> Unless you decide to go with the proposed approach of Trevor, where
>> "submodule.<name>.branch" set means attached (if it's not changed:
>> this thread is quite hard to follow...). To this end, Junio could sync
>> with more "long-timers" (Heiko?) submodule users/devs to understand if
>> this breaks too much or not.
>
> It is not immediately obvious to me why anybody who specifies the
> submodule.*.branch variable to say "I want _that_ branch" not to
> want to be on that branch but in a detached state, so from that
> perspective, submodule.*.attach feels superfluous.
>

Junio, for what it concerns me I fully support this patch as, IMO, it
makes cleaner the role of the property "submodule.<name>.branch".
Because with my original proposal I decided to go non-breaking Heiko
and Jens could also take position on this because this patch will
represent a small behavior break.

Also, and important feature should be added together with this patch:
a way to go "--remote" by default on an attached HEAD. This can be
done at least in two ways:
- explicit, non breaking way: add a "submodule.<name>.remote"
property. When set to "true" it implies "--remote" when doing "git
submodule update", both on attached and detached HEAD;
- implicit, breaking way: assume "--remote" when doing "git submodule
update" on an attached HEAD. I am quite sure this will break a couple
of submodule tests (I already tried it), probably for marginal
reasons.

I think this is needed because it makes little sense to having an
attached HEAD and "git submodule update" does nothing.

Thank you,
Francesco
