Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA721F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeKEJBW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:01:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47678 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbeKEJBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 04:01:22 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wA4NiPlK006109
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 18:44:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     "'Carlo Arenas'" <carenas@gmail.com>, <shoelzer@gmail.com>,
        <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        <johannes.schindelin@gmx.de>
References: <pull.64.git.gitgitgadget@gmail.com>        <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>        <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>        <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>        <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>        <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>        <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org> <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
Date:   Sun, 4 Nov 2018 18:44:18 -0500
Message-ID: <001101d47498$512b4bf0$f381e3d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIynbKOWDZU5yuDMC7jOCW2QfkT9AGywwunAXICJ1sBu1VHxQF2x5tWAmTvQmIByQs8oALR1LJppBk+cxA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 4, 2018 6:26 PM, Junio C Hamano, wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 03.11.18 um 09:14 schrieb Carlo Arenas:
> >> On Fri, Nov 2, 2018 at 9:44 AM Johannes Sixt <j6t@kdbg.org> wrote:
> >>>
> >>> +      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout -
> >>> + elapsed);
> >>
> >> nitpick: cast to DWORD instead of int
> >
> > No; timeout is of type int; after an explicit type cast we don't want
> > to have another implicit conversion.
> >
> > -- Hannes
> 
> OK, thanks.  It seems that the relative silence after this message is a
sign that
> the resulting patch after squashing is what everybody is happey with?

On my platform (HPE NonStop), DWORD is being defined as unsigned int
(32-bit) rather than unsigned long long (64 bit). The definition comes
through the odbc/windows.h include, not the compiler or any core definition.
It's only a nano-quibble (if even that), because GetTickCount64 is not
defined on the platform anyway, so this is probably not a big deal.

Cheers,
Randall


