Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A36C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5DD61951
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGEOFz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 5 Jul 2021 10:05:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57948 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGEOFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:05:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 165E3ABl013760
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Jul 2021 10:03:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'martin'" <test2@mfriebe.de>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com> <20210702100506.1422429-6-felipe.contreras@gmail.com> <8735sxaqln.fsf@evledraar.gmail.com> <60df8c20e8518_28bb20846@natae.notmuch> <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
In-Reply-To: <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
Subject: RE: [PATCH 5/5] config: add default aliases
Date:   Mon, 5 Jul 2021 10:02:57 -0400
Message-ID: <044e01d771a6$7c8cefc0$75a6cf40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFt4lYZIaBsC/3edPIiz2atDh3oKQJ0jboPAQ3wx9cCvhu9OQF3Qp8dq8nHxxA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2021 6:38 PM, martin wrote:
>To: Felipe Contreras <felipe.contreras@gmail.com>; Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>Cc: git@vger.kernel.org; Junio C Hamano <gitster@pobox.com>
>Subject: Re: [PATCH 5/5] config: add default aliases
>
>On 02/07/2021 23:58, Felipe Contreras wrote:
>> Ævar Arnfjörð Bjarmason wrote:
>>>> +ALIAS
>>>> +~~~~~
>>>> +'git rb'
>>> So 'r'e'b'ase, not 're'base.
>> I don't know if 're' makes more sense here.
>
>re:
>restore
>rebase
>reset
>
>And restore is on the level of checkout => so more important.

I do not want anything helping out the use of rebase, which we actively discourage in our shop - except for rebase --autosquash to fix up topic branches for delivery. git 're' is certainly not helpful.

From an earlier suggestion, why not just put all of your desired aliases in its own file somewhere and reference them through a construct in .gitconfig like:

include="/path/to/alias-config"

which would have to be implemented, but that decouples alias definitions from core git code and allows sharing of the definitions by a team without impinging on anyone else. I have great trepidation that users are going to start writing scripts using these aliases. I am going to be implementing a team standards document that would cause any use of aliases in scripts to fail code reviews - in fact, I'm looking to implement a commit hook that rejects the use of aliases in scripts that are committed.

