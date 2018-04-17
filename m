Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC481F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDQViu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:38:50 -0400
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com ([104.47.32.112]:36592
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751879AbeDQVit (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DqrX1Fnhddz4gVQ8wKCzPOJPlwVCwN2+6F2Fq5Kh/D8=;
 b=ImhipoNliIli0ONg+A8k5qRNriambXK62f53J6U3sonrlUJ0bmZ2puQvJ7DvxjfWigQJSZcab7erbVl+t9k0/deUUtaUbVZNNDZ0G0dw/5cNRIYQTPF8zS9wiwyUei/G1gZdWtNWZ0X5XLAEgs4KJX87q1dV9x6kFB1XVW0qDZM=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB3974.namprd08.prod.outlook.com (52.135.194.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.675.14; Tue, 17 Apr 2018 21:38:44 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62%13]) with mapi id 15.20.0675.015; Tue, 17 Apr
 2018 21:38:44 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Thandesha VK <thanvk@gmail.com>
CC:     Luke Diamand <luke@diamand.org>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to
 'fileSize'
Thread-Topic: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to
 'fileSize'
Thread-Index: AQHT1mhSkMWRON2QrUWk6Q3es/p1xaQFYKgAgAASF/mAAAVNgIAAAXJE
Date:   Tue, 17 Apr 2018 21:38:44 +0000
Message-ID: <BYAPR08MB3845AD0BC8F24814E0B9936EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com>
 <2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com>
 <CAE5ih7-iQsBxM3Gn4B1Q9WZ2A0=eTHn9nt3a0LVURppOCQsAWA@mail.gmail.com>
 <BYAPR08MB3845FEE1844EF613C739CB66DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>,<CAJJpmi8hb8iUDaNgrqxSTQAexgUcLQmiyBLx8MsHCa9BN9j43A@mail.gmail.com>
In-Reply-To: <CAJJpmi8hb8iUDaNgrqxSTQAexgUcLQmiyBLx8MsHCa9BN9j43A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: diamand.org; dkim=none (message not signed)
 header.d=none;diamand.org; dmarc=none action=none header.from=checkvideo.com;
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB3974;7:fvLMimSVVax9pnNAIKdGujGmbIDIl7FbQQt5QSLxNHu4iz/ZyklN6fZwTthFYubSOSSNmdYa5JHsYQO2IgF62VxNkOhzV3OulIzp34cdWEygUs8MhoO60y6EWFSyfazDbEZ8MDYq2WPmPHrsXkdU5BR0BcY/Qf7pGCBXnrpdh0gFl8M2WVMc1kq0niHblOYHbK5+lxDWXODYTyca+/HEbJmo+pM5LK1T7ES2Y/+0VVTNHmFwGNnqMC+jdqlMhLSS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3974;
x-ms-traffictypediagnostic: BYAPR08MB3974:
x-microsoft-antispam-prvs: <BYAPR08MB3974925D0C4B5A1234B4574DDAB70@BYAPR08MB3974.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BYAPR08MB3974;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3974;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(39060400002)(305945005)(1411001)(5250100002)(5660300001)(74316002)(53936002)(4326008)(25786009)(8676002)(8936002)(345774005)(81166006)(575784001)(6916009)(86362001)(6306002)(478600001)(66066001)(6246003)(93886005)(7736002)(3846002)(229853002)(7696005)(3280700002)(76176011)(6506007)(102836004)(53546011)(59450400001)(3660700001)(54906003)(99286004)(316002)(6116002)(2906002)(446003)(476003)(966005)(6436002)(26005)(11346002)(55016002)(186003)(14454004)(2900100001)(9686003)(33656002)(81973001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3974;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: c0/znh7u5EefGMKQWteXRVTYYXyBKyQ9nR6kERPcTPCAPEkkqhXk7bzpxdkdJ05Hn+jEAynW94Mpand5ZauQYdzNKFS3BjB1ug0chMnnrpksDAeiUhQ2uOaNhoyAlx4Mqx7E+dqMmNCxlNhXJhRwDMR+bf3tJnS1lKZWB1vNj/dVEfbS+Gz3ybqP/n1tBnxz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7d83c305-8646-4f26-03e1-08d5a4ab987c
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d83c305-8646-4f26-03e1-08d5a4ab987c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 21:38:44.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3974
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thandesha,

If I read your patch correctly, it adds a warning in case `p4 -G print` doe=
sn't return "fileSize" (not `p4 sizes`).
I don't see `p4 sizes` being used by git-p4 at all.
As I said earlier, for our ancient Perforce server, `p4 -G print` _never_ r=
eturns "fileSize".
So, it's definitely not a reason to abort.

Thank you,
Andrey

From: Thandesha VK <thanvk@gmail.com>
> My fix is for the case where p4 -G sizes not returning the key and
> value for fileSize. This can happen in some cases. Only option at that
> point of time is to warn the user about the problematic file and keep
> moving (or should we abort??)
>=20
> Thanks
> Thandesha
>=20
> On Tue, Apr 17, 2018 at 2:18 PM, Mazo, Andrey <amazo@checkvideo.com> wrot=
e:
>> Luke,
>>
>> Thank you for reviewing and acking my patch!
>> By the way, did you see Thandesha's proposed patch [1] to print a warnin=
g in case of the missing "fileSize" attribute?
>> Should we go that route instead?
>> Or should we try harder to get the size by running `p4 -G sizes`?
>>
>> [1]  https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fg=
Uq9YviobRpYGg@mail.gmail.com/t/#m6053d2031020e08edd24ada6c9eb49721ebc4e27
>>
>> Thank you,
>> Andrey
>>
>> From: Luke Diamand <luke@diamand.org>
>>> On Tue, 17 Apr 2018, 09:22 Andrey Mazo, <amazo@checkvideo.com> wrote:
>>>>=A0 Perforce server 2007.2 (and maybe others) doesn't return "fileSize"
>>>> attribute in its reply to `p4 -G print` command.
>>>> This causes the following traceback when running `git p4 sync --verbos=
e`:
>>>> """
>>>>=A0=A0=A0=A0 Traceback (most recent call last):
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 3839, in <=
module>
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 main()
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 3833, in m=
ain
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 if not cmd.run(args):
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 3567, in r=
un
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 self.importChanges(changes)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 3233, in i=
mportChanges
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 self.commit(description, filesForCommit, branc=
h, parent)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 2855, in c=
ommit
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 self.streamP4Files(files)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 2747, in s=
treamP4Files
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 cb=3DstreamP4FilesCbSelf)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 552, in p4=
CmdList
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 cb(entry)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 2741, in s=
treamP4FilesCbSelf
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 self.streamP4FilesCb(entry)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 2689, in s=
treamP4FilesCb
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 self.streamOneP4File(self.stream_file, self.st=
ream_contents)
>>>>=A0=A0=A0=A0=A0=A0 File "/usr/libexec/git-core/git-p4", line 2566, in s=
treamOneP4File
>>>>=A0=A0=A0=A0=A0=A0=A0=A0 size =3D int(self.stream_file['fileSize'])
>>>>=A0=A0=A0=A0 KeyError: 'fileSize'
>>>> """
>>>>
>>>> Fix this by omitting the file size information from the verbose print =
out.
>>>> Also, don't use "self.stream_file" directly,
>>>> but rather use passed in "file" argument.
>>>> (which point to the same "self.stream_file" for all existing callers)
>>>>
>>>> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
>>>> ---
>>>>=A0 git -p4.py | 8 ++++++--
>>>>=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/git-p4.py b/git-p4.py
>>>> index 7bb9cadc6..6f05f915a 100755
>>>> --- a/git-p4.py
>>>> +++ b/git-p4.py
>>>> @@ -2566,8 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 relPath =3D self.stripRepoPath(file['depotF=
ile'], self.branchPrefixes)
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 relPath =3D self.encodeWithUTF8(relPath)
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 if verbose:
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D int(self.stream_file['file=
Size'])
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys.stdout.write('\r%s --> %s (%i M=
B)\n' % (file['depotFile'], relPath, size/1024/1024))
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D file.get('fileSize', None)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if size is None:
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeStr =3D ''
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else:
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeStr =3D ' (%i MB)' =
% (int(size)/1024/1024)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys.stdout.write('\r%s --> %s%s\n' =
% (file['depotFile'], relPath, sizeStr))
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys.stdout.flush()
>>>>
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 (type_base, type_mods) =3D split_p4_type(fi=
le["type"])
>>>> --
>>>> 2.16.1
>>>>
>>> Thanks, that looks like a good fix to me.=A0 Ack.
>
> --=20
> Thanks & Regards
> Thandesha VK | Cellphone +1 (703) 459-5386
