Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C27C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348852AbiFOMpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbiFOMpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 08:45:31 -0400
Received: from mx0b-003d3601.pphosted.com (mx0b-003d3601.pphosted.com [205.220.178.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BD424B3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:45:29 -0700 (PDT)
Received: from pps.filterd (m0223446.ppops.net [127.0.0.1])
        by mx0b-003d3601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F2UA4k014706
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 08:45:29 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        by mx0b-003d3601.pphosted.com (PPS) with ESMTPS id 3gmpsn6rxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 08:45:29 -0400
Received: by mail-lj1-f197.google.com with SMTP id a17-20020a2eb171000000b002556cda407aso1867968ljm.9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cubicmotion-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UpVrIFjOoXr5GGGom1NKlFKb8OwGCKZXyXfzreGRj6g=;
        b=4NuLYwUzFmicig76G3bzVA/NTycXXoeB3/ssVy6/yv9sPmZbxCGW84QhzMKXIWA1tt
         wyMAqSeYmZVDQ6ROe2y7bCE3wCW1ZYkJTVkpTmOaIDfw0sCdlWHD+/KnmlNznqxlmySt
         pBzbeaRFKcUwvaI8GBK/gy299QRwHIVvewdV58llKcmZqvbgdmbMqNU6/6h0a9NaAowo
         ocsB2QAzYZXlc4MuIq0dBklxHfimZHkn77RyODfxq19Hj8yCjP8x9M/OSvxf4V8yw0NR
         GxshPQI8aiS/5QpLIEPgRPev9rOO0TwJpRjIvDnjVE7AgKm3nB8nsDjH2SIYDClnoRB3
         wzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UpVrIFjOoXr5GGGom1NKlFKb8OwGCKZXyXfzreGRj6g=;
        b=rGsW57eW8uhhotsfE/jiZJ5ovMBQ7MgpICv9e8IyvRc+09lZ3sgEOa9eMTtzUkSp6L
         g3+UhP3rsdoY98RozIx0Ph9yxyU0n/lwy0dZr4QkVvKh5qDWBqk8wJurBpbgfl+VxTmk
         HsD4xospEp6EL6NoH8aDNwkmgMCdn69kwhgLzSD8OLeNg2QXLu6x/im8tSqo8JX84GwW
         NgwPj+RkNPwn4RHRK7oRVU+L5TC7ELlkH0L4CtY790uDPkAJ6hZzgYrFPlwPa1E7p/fq
         sN+fuVWrnAt6JC/GfQ8a/hRQhoahxDb4GKX1K9Dz3/mizbujiuepW8bN16LeFu0NAOEF
         gTlw==
X-Gm-Message-State: AJIora9V280OPU6sV9r62FbsahlQPZvY5aUT2kWtnca4On8gPTEDmHJU
        3N2eR54HsTSiRCwLTv4acyJBLOkBbCCgAzYQ8aqgchWjLyJAuV1BsK64/dWywiIkM/Hzql42YWz
        iHZUmn0EyxhxZHcQoQ5ujVPVfGTpi
X-Received: by 2002:ac2:4e15:0:b0:479:7b8c:31fb with SMTP id e21-20020ac24e15000000b004797b8c31fbmr5989079lfr.13.1655297127102;
        Wed, 15 Jun 2022 05:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tc48IL/7wi3AVTQL0S9C8VRW7riZjMyRUiS0QWGVct18gcgmHDBDQ+Y5PrJzSCSlcbh8jvcTVD2lS6lhGxONI=
X-Received: by 2002:ac2:4e15:0:b0:479:7b8c:31fb with SMTP id
 e21-20020ac24e15000000b004797b8c31fbmr5989060lfr.13.1655297126750; Wed, 15
 Jun 2022 05:45:26 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Buricin <lukas.buricin@cubicmotion.com>
Date:   Wed, 15 Jun 2022 13:45:16 +0100
Message-ID: <CA+c+RB=ud_==QYJMgcwQ=X4imQhxsFvMuKp_bP0H_MBY1BbUgQ@mail.gmail.com>
Subject: Windows long file paths bug(s) with "-c core.longpaths=true" whilst cloning
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: xpLTkSsYpN83LeVVdc2le14DA21vmJjJ
X-Proofpoint-ORIG-GUID: xpLTkSsYpN83LeVVdc2le14DA21vmJjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_13,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=856 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150050
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am seeing multiple problems when cloning. I use "-c
core.longpaths=3Dtrue" and I of course have the long paths enabled in
Windows.

Cloning long file names appears to work only when the file names
themselves breach the limit MAX_PATH 260 characters, but not in other
cases.

1) When cloning in a directory path that is on its own longer than
MAX_PATH. For example, when cloning to

C:\my_very_long_named_directory_..._reaching_over_MAX_PATH_260_long

then the content of '.git' folder in

C:\my_very_long_named_directory_..._reaching_over_MAX_PATH_260_long\.git

fails to get created. Whilst this may seem like an unlikely scenario
for a single repository being in such a long-named directory, it can
happen with a more complex hierarchy of submodules, where the problem
becomes more obvious ("external" represents directories containing
submodules):

c:\my_projects\my_project\external\app_components\external\app_api_layer\ex=
ternal\framework\external\video_components\external\core_components\externa=
l\base\external\windows-third-parties\gtest\...

The first problem seems to be in compat\mingw.c, inside char
*mingw_mktemp(char *template) where we still use wchar_t
wtemplate[MAX_PATH];

After replacing it with MAX_LONG_PATH the problem moves further to
usages of xutftowcs_path() that internally assumes everything to be
just MAX_PATH.

When replaced all the calls to xutftowcs_path() with
xutftowcs_path_ex() providing MAX_LONG_PATH and passing
"core_long_paths", the initial parent git process moves on. However
...

2) The git process spawns another child git process, which doesn't
reflect the parent core_long_paths (being 1), because in the child
process it's 0, hence all the functions that should be allowed to
prepend the paths with \\?\ are told not to extend anything. This
obviously leads to more failures.

3) Even when the directory paths and the files do fit in the 260 limit
(I have shrunk all the paths by renaming 'external' to 'ext' in order
to fit in the MAX_PATH), git falls over in its internal .git folder
because it stores some information in significantly longer paths than
what is present in the repository itself. Using the example of

c:\my_projects\my_project\external\app_components\external\app_api_layer\ex=
ternal\framework\external\video_components\external\core_components\externa=
l\base\external\windows-third-parties\gtest\...

there will be folders 'modules' added at each level in the .git
internal folder for all submodules, so will end up somewhat like:

c:\my_projects\my_project\.git\modules\external\app_components\modules\exte=
rnal\app_api_layer\modules\external\framework\modules\external\video_compon=
ents\modules\external\core_components\modules\external\base\modules\externa=
l\windows-third-parties\modules\gtest\...

So the content in .git is much more likely to breach the MAX_PATH
limit than the repository "user" files themselves.

In general, aften seeing the code (admittedly first time ever), I also
have a few questions, because I might be missing some context ...

1) Why do we use MAX_PATH for buffers at all? This might be my
misunderstanding, but I would have thought that providing long file
name support would essentially mean not using that contant other than
for determining whether to prepend given wchar_t* output by \\?\ when
the input const char* is longer than MAX_PATH, before passing the
wchar_t* in Windows API calls? This conversion and eventual prepending
could be done in one place and should be no burden for the CPU.

2) Why not having long paths by default? Again, this might be me
missing some historical context of regression, but it just seems
logical to simply prepend by \\?\ whenever needed rather than fail.

3) Why to have a "-c core.longpaths=3Dtrue" command line argument at
all? Given that we can detect whether the long file names are enabled
in the OS, we could easily drop that argument and have the full
support for free? (Losing also the problem of passing the flag to
child git processes). In fact we might even not need the OS support
detection, we may simply rely on the Windows API return values and
GetLastError() whilst always proving MAX_LONG_PATH and eventually
prepending paths with \\?\.

Thank you very much in advance for consideration and for eventual explanati=
ons.

Have a nice day.

Lukas
