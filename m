Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A091B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 15:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfACPnE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Jan 2019 10:43:04 -0500
Received: from esg256-2.itc.swri.edu ([129.162.232.95]:43042 "EHLO
        esg256-2.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfACPnE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 10:43:04 -0500
X-Greylist: delayed 759 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 10:43:03 EST
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg256-2.itc.swri.edu (8.16.0.27/8.16.0.27) with ESMTPS id x03FUEZa147831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 3 Jan 2019 09:30:15 -0600
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX260.adm.swri.edu
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 09:30:14 -0600
Received: from MBX260.adm.swri.edu ([10.10.10.3]) by MBX260.adm.swri.edu
 ([10.10.10.3]) with mapi id 15.00.1395.000; Thu, 3 Jan 2019 09:30:14 -0600
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Marc Balmer <marc@msys.ch>, Duy Nguyen <pclouds@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Topic: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Index: AQHUoPOhBs+DBgT4BUyx7i00nvsJraWZEGEAgAAF3ACAAAIBAIAAASoAgANNh9CAAZJPgP//smQA
Date:   Thu, 3 Jan 2019 15:30:13 +0000
Message-ID: <02964c7abb7544259ba9f0d29ff32a45@MBX260.adm.swri.edu>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
 <59718f73a0a14b828a6d4fd4c8c222d1@MBX260.adm.swri.edu>
 <nycvar.QRO.7.76.6.1901031448260.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901031448260.45@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.162.26.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Hi Roger,
> 
> 
> On Wed, 2 Jan 2019, Strain, Roger L. wrote:
> 
> > TL;DR: Current script uses git rev-list to retrieve all commits which
> > are reachable from HEAD but not from <abc123>. Is there a syntax that
> > will instead return all commits reachable from HEAD, but stop
> traversing
> > when <abc123> is encountered? It's a subtle distinction, but
> important.
> 
> Maybe you are looking for the --ancestry-path option? Essentially, `git
> rev-list --ancestry-path A..B` will list only commits that are reachable
> from B, not reachable from A, but that *can* reach A (i.e. that are
> descendants of A).
> 
> Ciao,
> Johannes

Thanks for the suggestion, but I don't think that one does quite what is needed here. It did provide a good sample graph to consider, though. Subtree needs to rebuild history and tie things in to previously reconstructed commits. Here's the sample graph from the --ancestry-path portion of the git-rev-list manpage:

	    D---E-------F
	   /     \       \
	  B---C---G---H---I---J
	 /                     \
	A-------K---------------L--M

Subtree maps mainline commits to known subtree commits, so let's assume we have a mapping of D to D'. As documented, if we were to rev-list D..M normally, we'd get all commits except D itself, and D's ancestors B and A. So the "normal" result would be:

	        E-------F
	         \       \
	      C---G---H---I---J
	                       \
	        K---------------L--M

This is bad for subtree, because commit C's parent is B, which is not a known commit to subtree, and which wasn't included in the list of commits to convert. It therefore assumes C is an initial commit, which is wrong. Likewise K's parent A isn't in the list to convert, so K is assumed to be an initial commit, which also is wrong. (E is okay here, because E's parent is D, and D maps to D', so we can stitch that history together properly.)

By using --ancestry-path, we would instead get only the things directly between D and M, as documented:

	        E-------F
	         \       \
	          G---H---I---J
	                       \
	                        L--M

This actually moves us in the wrong direction, as now both G and L have one known parent and one unknown parent; I'm not sure how the script would handle this, but we actually end up with less information.

In this case, what I need is a way to trace back history along all merge parents, stopping only when I hit one of multiple known commits that I can directly tie back to. In this instance, subtree *knows* what D maps to, so any time D is encountered, we can stop tracing back. But if I can get to one of D's ancestors through another path, I need to keep following that path. Here's what I need for this to work properly:

	        E-------F
	         \       \
	  B---C---G---H---I---J
	 /                     \
	A-------K---------------L--M

To give one more example (since removing a single commit frankly isn't very interesting) let's say that I have known subtree mappings for both D = D' and G = G'. I would therefore need to find all commits which are ancestors of M, but stop tracing history when I reach *either* D or G. Note that if I can reach a commit from any other path, I still need to know about it. Here's what we ultimately would want to find:

	        E-------F
	                 \
	              H---I---J
	                       \
	A-------K---------------L--M

In this case, commit E will reference known commit D as a parent and maps to D', and is good. Commit H references known commit G as a parent and maps to G', and is good. Commit K references A, which itself is an initial commit so is converted to A' (just as it has been previous times subtree has run), and is good.

I'll keep digging around a little bit, but I'm starting to think the necessary plumbing for this operation might not exist. If I can't find it, I'll see if there's some way to unroll that recursive call.

-- 
Roger
