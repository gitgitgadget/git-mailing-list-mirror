Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D13C6FD1D
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 09:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCWJ5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCWJ4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 05:56:39 -0400
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3970B2B633
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 02:55:49 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 32N9tlg1016543
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 10:55:47 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 32N9tlg1016543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1679565347;
        bh=ldiKVV7Ww7VacJ7hR+1vEqHiQcWOVuerRMz++PMrRuU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Sen5zTVrkAx2zdJRAfpZbmTqya5h3QZ6Bx1ynLN4MlOkyC9CRY1MZSDEqJecmYHSj
         l3R2z52SRhkA1cqYWKe9EbPcflidfsovo0o8dFAQk9KZJW4hDmzyRlJ+0kC1Ut/gWT
         WL1k90IPBL2cakPy/zOa3w17tJR024TyNZOZFOSNfBWZrRqHpDRTbIHHEoSwAR8JcJ
         p09fMOdh5Rc25d6ih1X/6on9cKuKIf94+LfUBTiomdNXudfGlu8Wg/0oavT9m1PJIH
         hPtQblyekrUyNdxfugoTMyHe2ES6NgBgsB81Y0KwO72uT98lgQntwXftFt4TcrGZYj
         jgeirsHOQzsyg==
Received: from corpappl17778.corp.saab.se (corpappl17778.corp.saab.se [10.12.196.85])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 32N9tl2d815186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 10:55:47 +0100
Received: from corpappl17778.corp.saab.se (10.12.196.85) by
 corpappl17778.corp.saab.se (10.12.196.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 Mar 2023 10:55:47 +0100
Received: from corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18]) by
 corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18%14]) with mapi id
 15.02.1118.026; Thu, 23 Mar 2023 10:55:47 +0100
From:   Lundkvist Per <per.lundkvist@saabgroup.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Topic: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Index: AQHZW9YuL0XHoZNDkEewevJzAqRee68F9kUAgAC7M1iAANleAIAAmB6+
Date:   Thu, 23 Mar 2023 09:55:46 +0000
Message-ID: <f50de8a07d0448ae8929c5e0c8fba77c@saabgroup.com>
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
 <CABPp-BGnYWHtrM8fJN+79QLvm-GeXgJpxH4u=zvjJ0j9bUaE3A@mail.gmail.com>
 <573a64fb04584a4aa2329c471037d717@saabgroup.com>,<CABPp-BFeB9av00=HUt3-Q=e_croHHOKfFu0Oc=axkTQEddG9nQ@mail.gmail.com>
In-Reply-To: <CABPp-BFeB9av00=HUt3-Q=e_croHHOKfFu0Oc=axkTQEddG9nQ@mail.gmail.com>
Accept-Language: en-AU, sv-SE, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.16]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27520.006
x-tm-as-result: No-10--16.557500-8.000000
x-tmase-matchedrid: FYPNOy2BwYiJVA+ukO+5MXpXbwx9aHgaKQNhMboqZlrGZbX3v50Wr1et
        2+X+8Ssk+h4WVqRDM2TFCFz33zrM+JwnZiwx3fYmNT0Qrj4fxTXKIqAq0jIHitgHOcgfoB8RPe8
        xAlmWtaMx1ViN7STmkapbh9TgiUTj4xapGSHYrku7LWwix27pUiFq4bKNOR/1P4H+2nyK0FPQCa
        lGjynfE6OEq7xPrATGa5wp+sSRH+SBHpZLxu3sZN+Hu92fak/rEsGpOXjV8vs3eC/6ZUH89HIZB
        n/hHiM8JQrKbK03SGa/T7xRJQj08xwoVh4OYIxqExdS7WFvZWvUoMiU4Mi75Y0nZyQtGDZRDBsH
        p9ZCSqw8f15wVvhsZ2KRz0gGfdEJmcUNCy5hvn9IK0+m8U1xGO9Bi8r8zoNMnmeDuw6ngtwJO8g
        FMR0Bok02rmRwdqnxXBS1Vv+qjWzvnOSC+jk4DoeAntdoMxBaW+HVwTKSJIbozDhGeQC9EhczMZ
        GauuXu+BQ97Z1sHaTiMM0JmAUPe4KE6UDUw3acSCtgxgcsrMoQOcMSo0926oGjAri0gZeDo8WMk
        QWv6iWhMIDkR/KfwI2j49Ftap9EOwBXM346/+zFp8vgSOh1wyeimr9b41oZvbnZd1cWsBvrIVhk
        CFkUV7vzlwqFFJFC
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.557500-8.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27520.006
x-tm-snts-smtp: 6709AEE6CC34544CFE106E7A4361B11D8211C1453AFCBD4C5D0F7A559279F6192002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> wrote:

...
> So long as you use --remerge-diff rather than --cc, you should be able
> to rely on "empty output means the merge would be clean -- with the
> current merge algorithm and config options -- and match the results
> recorded in the merge commit".  I designed it to behave exactly that
> way, so if anyone ever discovers a case where --remerge-diff gives
> empty output despite that not being true, then that would be a bug we
> would need to investigate and fix.  And even if someone did make a
> merge commit using some other algorithm where it conflicted, and they
> tweaked it to fix the conflicts, show --remerge-diff would only come
> back empty if the tweaks made by that individual with the other merge
> algorithm happen to match what you'd get with a clean merge with Git's
> current merge algorithm and config options.  So, you'd be pretty safe
> from false positives.  You might have to wade through a some false
> negatives when merge algorithms or config options change, but as long
> as you're prepared for that, it shouldn't be a big deal.

OK, sounds good. We will definitely use --remerge-diff.

>
> So, if you did that, the major vectors left for an attacker to fool
> the "was this code from one of our employees, or from a merge from our
> CI system" that I can think of would be:
>   * trawl through your code review system to look for historical
> signed commits that passed CI with review comments like "We shouldn't
> do this; it'd open a security hole.", because they could then merge
> those bad changes.

Yes, this is the major issue.

>   * find systems that sign commits automatically (in a big enough
> organization there always seem to be exceptions to human-signed stuff.
> Maybe a system that autofixes obvious code issues and pushes up an
> amended-and-signed commit, or something similar, and perhaps the
> autofixing doesn't check the input was signed, or the nature of the
> autofixing can be controlled somehow.)

I think we would not allow this at all.

>   * figure out how to access the system that records which gpg keys
> are associated with employees, and add extra attacker-controlled
> gpg-keys to existing employees.
...

We would require keys to be properly verified with the owner before being
signed. Commits signed with unknown keys would be trivially detectable. Sin=
ce
OpenPGP supports a CA-like hierarchical trust model with delegation, we can
actually simplify this procedure a bit. An attacker would have to get acces=
s to
a CA private key, sign its own fake key(s) and upload this to our central
system. If they are able to do that then we're in big trouble.

There is always the issue of establishing initial trust. They might try to
inject their own CA keys for example. This requires not blindly trusting a =
key
without first verifying its validity and following other manual procedures.
