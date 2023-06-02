Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FDC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjFBIXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjFBIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 04:23:54 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479B18C
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 01:23:52 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 9438A23FF7;
        Fri,  2 Jun 2023 04:23:50 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1q504c-ECr-00; Fri, 02 Jun 2023 10:23:50 +0200
Date:   Fri, 2 Jun 2023 10:23:50 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] ref-filter: add new "signature" atom
Message-ID: <ZHmnFiykAixYUCgm@ugly>
References: <20230529192209.17747-1-five231003@gmail.com>
 <20230602023105.17979-1-five231003@gmail.com>
 <20230602023105.17979-3-five231003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230602023105.17979-3-five231003@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

just some nitpicks from me:

On Fri, Jun 02, 2023 at 07:41:55AM +0530, Kousik Sanagavarapu wrote:
>Duplicate the code for outputting the signature and it's other
>
"its", not "it's". this repeats all over the place, so please look up 
the rules.

>+static void grab_signature(struct atom_value *val, int deref, struct 
>object *obj)
>+{

>+		if (!skip_prefix(name, "signature", &name) || (*name &&
>+			*name != ':'))
>+			continue;
>
this looks confusing.

but there appears to be no exception to the "no excess braces" rule for 
multi-line conditions, unlike for bodies - maybe there should be?

also, i would wrap logically, not right at the margin, so

	if (!skip_prefix(name, "signature", &name) ||
	    (*name && *name != ':'))

>+		else if (atom->u.signature.option == S_GRADE) {
>
brace symmetry rule violated.

>+			case 'R':
>+				v->s = xstrfmt("%c", (char)sigc.result);
>+			}
>
omitting the final 'break' looks like bad style to me.

regards,
ossi
