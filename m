Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C1C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F62615E2
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbhI3IIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:08:02 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:64338
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349306AbhI3IHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 04:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9OHnldN053o/PxHvocC/E8CWZg7laym4O3+lypacxiZafOyVyUeg8ruGEVWc6TwWKYHCqOxAayF6gisRJ+22qutSyjzdokW9m233icqJZaiZL+NVClcJBWWHCjAYnhUrsR3Fg4yiiQ7uCVwG8iSxGP2S9UgB9YlyOH8wOPI3Yf9C94WphUcMUwOPSgIHb+bLWI8mXXHs8DBo2P+C6uhR07TZkVZlomOB+/SbX6hjBkU9BAKG8j+euEJvGijIhrTKZ/fXRvdodcSsPyEjAV11b2PzP9BugaoI7SnPWSYCUoid2T/htq4sjLCM4KOy2ASGLCA86H0g4kqRcmi9y4RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7z6SLWA4z+nWmCtG4vRH/kQh+rHXIvF9G26jInpcz1I=;
 b=ew4PnWLUzQn8hiHT5NQuU/afNixIUtZ/if28ITWQeny7cBxC2hJs6szrKtwnAaJ+4EoUFZkDLN5+DzpYl8L/TLVC6OnR8a2DVEUD4dQdINpXI5/IR1a1l/wvLBrSwAQhQDBp7Mj4UxOgRKilC49k+L05yOMYf9uskISZqJMwd95f7uwdAkuwXrunKS2iLSjVM7bnX7yMHcdN66G8Jxe8um1bhUaLiBYWK7XjCj8038fLl0w9IoWZKysRVWlghod/u3BGw8ABKIBUhqup7oFHs8SQZZyw8VTgK9moMWENnVPNrdg4BlOjDeWeMWexlsEm+wtKd4RbBGEaPXpjZ93NdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z6SLWA4z+nWmCtG4vRH/kQh+rHXIvF9G26jInpcz1I=;
 b=ERkdJMMlthE5S+EjkoZHe4lSKlHX3xGW950PAlXtutgvc5/ZcKL5tU7zSW2MsEH8W8xE1/ukjDGpyp5IIKCQzStFQ5dla1m77bhYRrsotIoKJXmLU4TVKm1cnb1zFP3aXx8JHpTSTDn3pggjKRdmJEYJCZkMf6eSMrnTkccPwDI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4478.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 08:05:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%7]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 08:05:14 +0000
Message-ID: <435d33d0-8991-d8c5-85b0-928ec97310c6@gigacodes.de>
Date:   Thu, 30 Sep 2021 10:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Feature Request: `git commit --amend-to`
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Aidan Gallagher <aidgal2@gmail.com>, git@vger.kernel.org
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
 <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
 <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87y27gv5bk.fsf@evledraar.gmail.com>
 <kl6lwnmzpbhq.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <kl6lwnmzpbhq.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0048.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:4db6:1dfa:2076:87b5] (2003:ea:5820:600:4db6:1dfa:2076:87b5) by AS9PR06CA0048.eurprd06.prod.outlook.com (2603:10a6:20b:463::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 08:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7389c63-7e6c-4931-c753-08d983e90892
X-MS-TrafficTypeDiagnostic: PA4PR10MB4478:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4478BFE2E65574A253EA19BEB6AA9@PA4PR10MB4478.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKHFcWRVH4083Q7YeqAg7UrOx+bArGM9BTFwoyWYXZtadLuXJMtHpHLFae6fSV97HAjoq5URJSUe3VmN8HlCwv9MubDiuD7Pf57KYR+gLSFLpeo+QlQxzj5McTmxvPSKPHwzZpDy0ab+INrSPNZHA1nvjyZPtzxNqvA/Y43AzvECSsZSbA1WzfI0V4V9T/1hLsvQNu33sz1cN4ZtUzCwC6lIHZlHVuCu/VBSaCp6X6AC1G4E6dBo9y0ywQIZTYhdzClIVsE+c40t8LWBe79/UcLJGEbvzX9G1nnaK7OhE4sXXP1kbUE6TZMfxzODzNcEKPLsVHqKsDkTo8UcCmHYaODruoZxc/SQy6E+SN/lFL7D6EtnHLt4X5tgZMN+QAQAu4LzGfoQ23iaYfPgXyPMc8JO8PRH+rU+CKNMkWIn8mhXLO6WvD9r5oQC/mESIMr+4yYjEqFbE1Nb3UGsvX7wZ+IuHutbSuLkysHYaNB5KL+wMXOfBXPxvKOduixf05hLduaInvJe77GNLYK9+8FqWovvj3/rsKVqcD+lsQ5B9Xgjd3bCDIqW9Uyq30aSGFQ5QCt+i5lhBP8O4DNyryA6rDfTrmuBi4FQML3NnU2oPdViHAyJ2HJPU+xqTQT52fcDuz8JbgBTqxXqL02nK5CPgha6f7muVha6OP544WmYMFVaS8D7RMv5oQDtdtNX1a/AaY/IWtbMQJo+xn068EhAYF68AloA37CYqmLgjWh+G8LFNpndpWMON9Q8IiyyDqMd2s9PifhC9sRTZbUMj95sUuNoBbsA+nyVOWbzrlfLybBfjkwItWvRINJQ/MySxPTmOLaSXhZrbIvw/0eR7wS8g3oSz18jo4M7JWYd192LSaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(376002)(346002)(366004)(136003)(396003)(508600001)(31696002)(316002)(6486002)(54906003)(966005)(2616005)(5660300002)(53546011)(110136005)(186003)(66574015)(31686004)(66476007)(66556008)(2906002)(38100700002)(86362001)(36756003)(66946007)(52116002)(8936002)(8676002)(4326008)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDMzeTJwcENySE95STVNUmNUaFpDMXlKV3VhN3pOSmpKWlpXaG5QQjgzM1lO?=
 =?utf-8?B?dzVRU3Y3WGVUWUtSMmR2M1p0ZU0xSDJ3cUN4RTlqUmJTWXQ3cS81ak1mTGdQ?=
 =?utf-8?B?TmhLSnVyMktRbGg5WGhwNnM5eWpQOC9sTmZLSFJaVGhlVmFOZnFtbFd4blUw?=
 =?utf-8?B?MmgzTnU3emRmbzA3WFdML2lVaXM5OFk2TjZvcTNzQWxPakk5RnRkcXUwV0ZG?=
 =?utf-8?B?Ni9GdUZ4WlRxazJybGl4dlF0QSt5dFMyZWtyNWtRU3I1aDJHSERUZkI3Y1dP?=
 =?utf-8?B?RXRoYlloaVpaUkZtMWRTVjhmZWJDd2pzZFZVa1BQZjFOelB2TVN6aDdpdmt1?=
 =?utf-8?B?TFV2TjRsK2NsSFJaa2o4THhmU2FYbWFHaDkyME0vR3llY1JCdTJ0L0Q0cU1t?=
 =?utf-8?B?dFRvd3NncFhnaXF2TEluQzlLRGdaanBPbTlSd0lsdDlJQU13OEdJRDFUU2Jv?=
 =?utf-8?B?NCtDOE85eVFHYy92bXVLWUtFdXpXaG9rMDB3VUxEMUJNa0EvTzZaWVRveUh4?=
 =?utf-8?B?djBkMitVS1JjVWluNHVmZnJiclhGenhzYmE3dE9IQ2wrdXFDT1pPTmRhSjZv?=
 =?utf-8?B?dDdEMnU4MVl2cGNqSzdPUU1sYmJHdkxKWCtqZXF4OGFEeXkwbHdERi9CR1Fz?=
 =?utf-8?B?K1A2Z3lndTFFallhc2tuY1ZmR0xVNXlUM3pKa2NNditvaHg2V0srT24wTkJE?=
 =?utf-8?B?ZE9mdCthNFd3UElSNFNSWXpVVDdRM1lIdllXMmNiVDBRYW9xTkx4MnhlV1FO?=
 =?utf-8?B?QnJZMWx1RHJ4WEtPTGhObUcyamZ1TkhFamRTeEhFRHlBVHpMVkF2NXRYR20y?=
 =?utf-8?B?T0p1UlM2cGhpVjJ2REdrWDl5VmNBanlGb1RMd3Vtb2t5MGZJbHpUWVNreUMr?=
 =?utf-8?B?UnNraEFmUVZaNGFXWnRCTjI5WjNaZnZVRVhYOVM1dE5jQ25RZkY0MzZYQ2Fz?=
 =?utf-8?B?OU1CcVdPUFRudDNGZmxkeTczbDJoeDQzZ3o2RzgyOXRoMS81bjBjalNheVJn?=
 =?utf-8?B?VTRmUERRTWs3Y09aTjhYZTJvcTBqTmU5ZDRMdVVDRk5jT3BkczdGeXdwUitC?=
 =?utf-8?B?VEdFWVpHRHZwNW1kL0F2L09HbmUvcTdTRzYxOXplVDgrYlIxLzFycmMrZW91?=
 =?utf-8?B?bzNsYnhjSmJRSTJocVdUeFdDOVd2NUUvcXN0TGdKK0kwOWUrdEF6MCtGOFRw?=
 =?utf-8?B?ZzlaWUhnZXBoTjRqZE1KK1l2Z1VIaTQwdElONjA4QmV1cjNQMHZQYXVobXhR?=
 =?utf-8?B?dDRvNE9FdmpNbFpKd0ZOUmNCa3d2Y1R0VXVJS1NJNEpDajIwTjBoY2RnZ0ZP?=
 =?utf-8?B?K200MlVOVXl0YWJZcWoxTk1rRS92OHFDWDlpMDJoZ3NDb2hiQ2c2WjR3czV0?=
 =?utf-8?B?S0ZlQ09PRFd3VWgzVFRTSEdRWDRlcWxZTE9IYzVEWEk3ZWRZYnlHQi8zSlNE?=
 =?utf-8?B?QkJiKyswSmZ5YUpSK2UvQmJCZFV3bVZBL2NFN3RFelpQQmRtWmpCOVI0U1Vp?=
 =?utf-8?B?amJqcmI3OVgxTHM0YzhjeDBmdnAzMy9OaFZFQzR6MDhyMmtOaThISm02SGFV?=
 =?utf-8?B?TFNQT25LSG9hNVNWVmhUNUJUQ05SNEdXUngvMk5WN2h3Yk40Q05PeXA4Qmtt?=
 =?utf-8?B?K2JJaldkUmFvbjBXQlQzdzNyejFUblZQMlNzVm52aGVndEcyeFhtcWRtMnIz?=
 =?utf-8?B?cnRTZVc5Wk4vd1pnZno4VEgvaDlQdmhrajNVQ1Z3U1Bobk9pZTNQZkxmSWJH?=
 =?utf-8?B?bVBXUWYyUmRYdlhtdVNyRmhjb05VZGFjUmZDU1JSdUFhaHBsOXdsQWNTZHBx?=
 =?utf-8?B?TTZyVHhZbHNtSTlkZnEyME1uRkRpSnIrUWFCdDNDeXJlVkRCeXBCcStiWGJQ?=
 =?utf-8?Q?Fz0TVsP4Ck+4x?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c7389c63-7e6c-4931-c753-08d983e90892
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 08:05:14.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Glf6ICticmsPdK/PrV1qlfqhyLJRyuAna37syOV6nI5xr76+U2Z2hma4pguxcT0bGntX+4mL5XF6sEMUmAE8g8CYPbgZD8w7zYKjA39p/ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4478
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.09.21 18:55, Glen Choo wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>> [...] I think the problem
>>> has more to do with how Git manages merges and conflicts and less to do
>>> with having shortcuts in the CLI.
>>
>> I think that users who'd like an --amend-to would probably be happy with
>> or might want to try out something like "hg absorb", which is something
>> I think we should have stolen in git already, but it's never too late.
> 
> Agree. I think some "hg absorb" features get at the heart of what I
> meant, which is that users would benefit from making this merge conflict
> resolution a lot simpler.
> 

I have never used hg absorb but after reading about its concepts i think
it best maps to something like git automatically creating fixup commits
for you. I also found https://github.com/tummychow/git-absorb (also
untested by me) which claims to do exactly this.

Something like having "git commit -a --fixup" (without any commit hash)
create matching fixup commits for all changes i made would already be
quite cool.

From what i see from our corporate environments and github/bitbucket
workflows though i think most users never even heard about fixup commits
or ever did an interactive rebase (this is totally a view from my
corporate bubble and might not really represent the average git userbase).
Most code review workflows i see don't focus on individual commits and
only present the complete final patch (some at least allow you to view
individual commits but not much more) and therefore users have no big
incentive during review to shape their changes into proper commits.
Some tools (like phabricator) even squash the final patch into a single
commit by default which i think is a good idea if single commits are of
no concern during review anyway.

I wonder if something like an easy to use "absorb" feature (without
fixups, rebases) might encourage and produce more clean commit histories
even for the mentioned workflows.

