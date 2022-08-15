Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFB2C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 06:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiHOGex (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 02:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiHOGew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 02:34:52 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4600C1A3A6
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660545283;
        bh=LiNSYq7UrOkaZSJFiV3HKSaE1rBuQMrNFulxnZoVuME=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=B1JPzSih7KII1U7l/0MqSbJYaK2J/Kx319MOyAONiL6lodXkCPZOq0awH7mQHxGqN
         5F79a75CNDJJ/oa0hO2y7CqVgVkY9o3rzZBYBSMkF3hIwJX7qBwcUuz3IQwexx3DpG
         R3rFSEHj2FqNwxM4kSftBvcQ1SLOAkCWeBsK3mo4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1nbTlI38i2-00nRpR; Mon, 15
 Aug 2022 08:34:42 +0200
Date:   Mon, 15 Aug 2022 08:34:41 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH/RFC 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20220815063441.uxrtdqsggmrqxxl2@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220814133531.16952-1-tboegi@web.de>
 <xmqqfshy773n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfshy773n.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:i01WdoZ6viDmNQVUyD3D2OPODHElXm5iNMG/gcRB2uWzQGqmm1c
 oQjLrsxTDKEHb5ESTHA6LkduWxO9/19uIc2DwbqSymYuPh5ooebyhMeQven00snb9RtVXJB
 HP5KfcVXff5v+k4WJXm8YpM9brSBmGwHPZaTggpPw/5wCvKXQoYAveLDcMpRweq7iGbrtBq
 fKxwMfqrmgQybBbeCnXqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T13Z2Srfcww=:4THA47sYEFVi+Xf5iEGrUS
 Fl9AVDMJ240HW+d75yBrnvfKGE+SR89GMzN77/VupmrzHkXIpcQXIdmfRWjEf+na3Tx3IMZAN
 kxw5uyAn5Bjlzemf31KCyTrUQW5sNSYZWDY/fdusG8qb8evwj4UTncZu3Ag3mokzI4RlWhesu
 3UFtiRo9yEPmCjxz4kKrMkrSuIExpsNyJacqxk7eXp6UQ3cih2NWV/R+ukOsEsLWvWUUtR1Ww
 zw7YBpp/ja2BDamo2/nVFXgyIr2OBoXlESunfznFedql5C+XyJHhLaok+LpTHbyYJqwppJ7yO
 r1RNOEvt9SNHX9/Cpeheha3rJHEl3AQEo3smbDo8SKnJXbfFTivHxlRbvvadjSu+22dgNOBcV
 9q1M33eekQ4p+yXhjhXVPajkZT7cJw6RjKw8EzVW4aKxBcC1adZLMNCvPV/odmoEdXRAv1O7S
 sDJ1zQxTfAZ8ij4TauDQTyLoV1D0wvPFZaDNzPW3y50DERr9ju/i9LFxWECMVoVYA2C1wI8Ym
 GWaU/ET42wH/1O/nFSG8zPwJYkKfLgyQhOkNXIYTL/bTp+902+3+RXGC1Ew9c9t/3TTUO47eG
 sQo5GEGFHViaasLbPLOIkp3oOrDohR24TL3hEeBNm6kZgqMJEvUJiTW+S35LXAhesvXjOg56Y
 4umd1Kbrn0gM7siFznR0tLWk/ZWfDVQms5D4QbiqBcHTq+HLeEoVMws7U4pqQj2wczVQWnWnk
 yFBuYwg/xrPS7lAei46jUX6jv8fqg8xXTlxRQ8iugICTXIhB18Sukd6C1wu9+awHzHeAz9gpX
 YjFYERWHksfLRr1CJO9z3di2vBHnOpkYVD8ZRD4wJFXb5uBy/74rGlbbR9eAgK0CW7EoVLhHt
 6tk+CgUrcel0hAuaGxg31czSjc2baSMT4djMsH/LURPQMIWZ5pklMHJ0uZwKD06LRNnY1f5Z9
 UQiuC9sHchbPCL30xIn897PMyxdMhUnhh66e/lxchD5elZYTykAyFQ5r3Nm6+GFnwemTittSb
 PHJyjBeBieD6Iu44Y8sYbkysmd0BCmxi6vzvs2gGdTpJb91YXgsvt32TfPAgu0Fw+4RtEo3Np
 bHJu4xuisMQUhct44iwNv79/UmOrYDbQAuVCYmZkDD2cqhO8gM3Tjzgew==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2022 at 04:12:12PM -0700, Junio C Hamano wrote:
> tboegi@web.de writes:
>
> > The choosen solution is to split code in diff.c like this
> >
> > strbuf_addf(&out, "%-*s", len, name);
> >
> > into 2 calls, like this:
> >
> > strbuf_addf(&out, "%s", name);
> > if (len > utf8_strwidth(name))
> >     strbuf_addchars(&out, ' ', len - utf8_strwidth(name));
>
> Makes sense.  Is utf8_strwidth(name) cheap enough that we can call
> it twice in a row on the same string casually, or should we avoid it
> with a new variable?
>
> It might be worth doing a helper function, even?
>
> 	static inline strbuf_pad(struct strbuf *out, const char *s, size_t widt=
h)
> 	{
> 		size_t w =3D utf8_strwidth(s);
>
> 		strbuf_addstr(out, s);
> 		if (w < width)
> 			strbuf_addchars(out, ' ', width - w);
> 	}
>
> Other than that, sounds very sensible.
>

Thanks for the review.

Actually, the commit message is wrong - after writing it, the code
was changed into

if (len > utf8_strwidth(name))
        num_padding_spaces =3D len - utf8_strwidth(name);

and later

if (num_padding_spaces)
	strbuf_addchars(&out, ' ', num_padding_spaces);

(And having written this, there is probably room for test cases,
IOW: a V2 will come the next days)
