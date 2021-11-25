Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A491C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357128AbhKYVCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 16:02:33 -0500
Received: from mail-am6eur05olkn2109.outbound.protection.outlook.com ([40.92.91.109]:17025
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237400AbhKYVA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 16:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCC/kuh3WGfBocpsjPlZTnDQ74ZCfxpmW/g2u1682Xc9Jg2X+QY6uVYhP+HlsQwvk9xL+6uPzPAdMeq0FNEEiLcqfiML1qu2yWUD9as4OPzsUebJ8jg2XjjWo2pV12LHltUiztN8oIYS8v//soFTAtKRFLxllPHRmrLN3eOhvXgS9zKLROBDT2EpJX2ALRX30Zz0i/nJyLMCdzRp10avtO00wAP9hBMoojzpu5w8sDmAo8JILzvy+US7ng+KkWiPD0+89Sf3RiswZIVYoRG7MfFFPFzzi7btraiMl3/U0Bq9M2t6hSrw5QbWWydaWjeiKYd2ybgJ2GU4605Iwid7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJbIFpLTQn7dqInsHJWCfIqmxEVjdO9TnswBM+ZS8cs=;
 b=MjCx4avziRu2kBGsr+6ExcbGXJoYeTn/Jj39Oxo3DCfx1YbRHvw8TmySF/pJgkUWmRbTMHudd76v3evZmyOIz97UlkMHovJnuPfyi3KQpl5NZmHboo4G6HebSHQoq1n778/MHL6KBWR9OYEbfJjiNCBIAvgGHGF6YtRNPGkWgIpqqKZlS4RZxZTSMpjo6tGOcbRDxdtFt2TRa23/y1DoGC7sxxTmQqdAwlkHPqkUO2g+mTji3KbNaORllQZ+gyyCpW8kBmYFbepuzs+Qhor/pjP8sIXjtBOQInl2UMA1bdleEaJudrMsKOJBogCl1ugZ18a1rJe7ALcDE0cAK+dd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB5378.eurprd04.prod.outlook.com (2603:10a6:208:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 20:57:15 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::2d2f:78e3:4b3d:8cc4]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::2d2f:78e3:4b3d:8cc4%3]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 20:57:15 +0000
Date:   Thu, 25 Nov 2021 21:57:13 +0100 (CET)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
In-Reply-To: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
Message-ID: <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN:  [GfwjjOrpD8Sm1P5kBWex1SkzLNVki0fi6Kfn9pG4Y+JtKG/0jg4XC2FUpZZotOMO]
X-ClientProxiedBy: AM6PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::31) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <2ed0ee96-9089-27e3-561d-279c80b9b99e@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from p200300d3bf1ff70028527554ee46ec16.dip0.t-ipconnect.de (2003:d3:bf1f:f700:2852:7554:ee46:ec16) by AM6PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 20:57:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f464e90b-7da9-4ffa-959c-08d9b056288e
X-MS-TrafficTypeDiagnostic: AM0PR04MB5378:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDCEq/oIJiyckOev/FcH7CpTLjsPx9KD52VX1TCwr+7aIZ4NiOP7AdedksgaBJMEsweIpY8K2pf6r/O81w1k9YRq4uz5JW95S91nBsPg2cxHqQRZmQ9bwo6FoxApG4CZKfj/hbJMMQjCFglFF1oZCjGrCDDLV4GfjXx95o7+Sw9x6h4oBj7K5sM71cU1CcS26VR05lKjwnAde+SApIxTCSJrd+nXFFGCW6ScbSDYUTnVfergpsLEFCWL3JfJNAmGUAQHTeDetyoBqU2p9ovB6CALtGPcIk+nULlRBNRWmMjmTH8bIq4zzTI/Ph3jBRbG62NHrQ3EbYDduu5hbRBcHGhkbvQr/kNevLxRvOgQlKh+a5F2voNwCJysSz3PrQC4QuXM7EzrDlRH2dji9ATDGLCMZ2R12RICUgOUAOmzLzkYoFZkMo/efS0qtGj1m1VBcQr6tOC2byCq+rCUAyC9cCBy28ceqX8SE2IzWjvpa6wKSJsE8+AUOJMzOu/yK6kTXDuoxDROfDg2QxI9en1DnJcHjo1dSEzl8c7JXnyk0ygRf2iGn3Q9itX1X9wWoVbYmPqK9ga3TRbKv4vvVFnqFqymomOk4i5v1BEizo2qNg5YUScjrWIDUAlWxDXj0Njv5QNmttFTO4pA4nNMK9f6oMFlhszPxWK5ZbTX4/zZgo4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9iCBaJSLujoWyEGZakHgIp3zGK6WVUIGZfTJg09MA7ovkhHvVDD0vBcF9byw2wZ4MlEiiyt637jI0sAinDmO3HtCkhW0IuHdKrDtdVnCVDhYb+XyrxgB504M8dti9kHYwINhuAMHsFbRD/jWa2/+ho4erysfnwCVIPaAwwCNQHCJcQEy4JQXqYcViW4taEwLf0Bf/djn2ybJR4QReVqIJuIhAoMpinA7Tfdkk/TbSqlJerbDb5B1vCAIz2AtRc420tJsfDHKoAviSfNfUxjXAZ/JxppV1t95ibOhl2XVTZUXWMs/K6ifY1Cnlr5+yQs91A7AH3wioS0U3xK1ZdPdEM56m9UkzQLF0MCm8OLO2NhjFQuBI/9hdrzDP+U+1i9j91dR154a2AKXSefiVOYkzxBY/1M2rol8aGyU5hfgXJbpSq6ewr4Hf032X19ZmC5RwYrD1ynZBaAa48/aB6rd3JQQpvK02II9K7fZbq5ZjSxUn3SazvVaWPE3xqU/FbKcCtWnrA0xrIfWYhCcpkUjQb89+3W8Ab8/2i9JRItdjcy2/TeW8c1RKOsmGwW8l/GKSNvkFJuOPLsmiSJXNyK6kggHomSdPs51plN7y4EFoOk8HzFGsBixVitgoPdQRdEHjR3bzRrG+4ZrdfFJsSqgimmsbIfhamRXezdBPC/Jut3u1wVTBMH0o0jQrshAAHS97+4pxrDt4in91QExR2RxdPI09ZPqTnwQf1OKZ0MewrzC9u7HM3VbjXB4FS341rqzSXAUHccD+/voPo70qKyBqA==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-adf9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f464e90b-7da9-4ffa-959c-08d9b056288e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 20:57:14.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5378
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Mahdi,

I've already written up these concerns on GitHub [1] and you've replied 
there, but Johannes asked me to also send this to the mailing list, so 
please bear with me for mostly repeating the same points.

On Thu, 25 Nov 2021, Mahdi Hosseinzadeh via GitGitGadget wrote:

> From: Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
>
> GitHub now allows users to subscribe only to
> "release" notifications of a repository.
> So, users can be notified of new releases and their
> changelog/release notes automatically.
>
> This workflow works whenever:
>    a new version tag
>    (with the format following the regex "v\d+\..*")
>    is pushed to the repository
> AND
>    the commit that the tag points to, created/modified
>    a release notes file from Doumentation/RelNotes/ directory.
>
> The script for generating the temporary changelog file is
> written in Kotlin language which can be a much better alternative
> to shell scripts in terms of features and readability
> (it is like a python script but with static typing support).
> The Kotlin runner is pre-installed in GitHub Actions environments;
> for more information see
>    https://github.com/actions/virtual-environments/
>    https://stackoverflow.com/a/69116750/8583692
>
> The "Release Notes (yyyy-MM-dd)" link in https://git-scm.com/
> website can also link to these GitHub release pages instead of
> to the raw .txt release note file in the repository.
>
> See the issue related to GitHub release notifications:
> https://github.com/isaacs/github/issues/410
>
> Also see GitHub announcement for this feature:
> https://github.blog/changelog/2018-11-27-watch-releases/

Nit: "Github now allows users" sounds like a new feature, not one that's 
three years old.

>
> Signed-off-by: Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
> ---
>    Add a workflow for creating GitHub release notes
>
>    Because this is not directly the git code and is related to GitHub CI, I
>    post it here.
>
>    This pull request adds a new GitHub Actions workflow that automatically
>    creates releases on GitHub repository when pushing a new tag to the
>    repository.
>
>    GitHub now allows users to subscribe only to "release" notifications of
>    a repository. So, users can be notified of new releases and their
>    changelog/release notes automatically.
>
>    This workflow works whenever: a new version tag (with the format
>    following the regex v\d+\..*) is pushed to the repository AND the commit
>    that the tag points to, created/modified a release notes file from
>    Doumentation/RelNotes/ directory.
>
>    The script for generating the temporary changelog file is written in
>    Kotlin language [https://kotlinlang.org/] which can be a better
>    alternative to shell scripts in terms of features and readability (it is
>    like a python script but with static typing support). The Kotlin runner
>    is pre-installed in GitHub Actions environments; for more information
>    see https://github.com/actions/virtual-environments/
>    https://stackoverflow.com/a/69116750/8583692
>
>    The Release Notes (yyyy-MM-dd) link in https://git-scm.com/ website can
>    also link to these GitHub release pages instead of to the raw .txt
>    release note file in the repository.
>
>    See the issue related to GitHub release notifications:
>    https://github.com/isaacs/github/issues/410
>
>    Also see GitHub announcement for this feature:
>    https://github.blog/changelog/2018-11-27-watch-releases/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1146%2Fmahozad%2Fadd-github-releases-workflow-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1146/mahozad/add-github-releases-workflow-v1
> Pull-Request: https://github.com/git/git/pull/1146
>
> .../generate-github-changelog.main.kts        | 21 ++++++++++
> .github/workflows/create-release.yml          | 40 +++++++++++++++++++
> 2 files changed, 61 insertions(+)
> create mode 100644 .github/scripts/generate-github-changelog.main.kts
> create mode 100644 .github/workflows/create-release.yml
>
> diff --git a/.github/scripts/generate-github-changelog.main.kts b/.github/scripts/generate-github-changelog.main.kts
> new file mode 100644
> index 00000000000..e57fd2a6ae5
> --- /dev/null
> +++ b/.github/scripts/generate-github-changelog.main.kts
> @@ -0,0 +1,21 @@
> +#!/usr/bin/env kotlin
> +
> +/**
> + * Copies contents of the release notes file created/modified
> + * in this commit to a new file to be used by the workflow.
> + */
> +
> +import java.io.File
> +
> +println("Files modified in this commit:")
> +args.forEachIndexed { index, name ->
> +    println("\t${index + 1}- $name")
> +}
> +
> +val notesFile = args
> +    .map(::File)
> +    .singleOrNull { "RelNotes" in it.parent }
> +
> +notesFile
> +    ?.copyTo(File("changelog.txt"))
> +    ?: println("No release notes file modified in this commit")

We need to spin up a JVM for 21 lines of code just to copy a single 
file. I think a single call of `cp` is faster and more readable than that.

> diff --git a/.github/workflows/create-release.yml b/.github/workflows/create-release.yml
> new file mode 100644
> index 00000000000..711ba105e42
> --- /dev/null
> +++ b/.github/workflows/create-release.yml
> @@ -0,0 +1,40 @@
> +name: Create GH release
> +
> +# Create a GitHub release for each new tag.
> +# The release notes are taken from the release notes file
> +# modified in that commit located in Documentation/RelNotes directory.
> +
> +on:
> +  push:
> +    tags:
> +      - v[0-9]+.*

I think we should probably exclude the release candidates from this. As 
Johhannes pointed out[2], marking them as full releases would 
periodically cause https://github.com/git/git/releases/latest to point
to a pre-release instead of the latest full release.

> +
> +permissions:
> +  contents: write
> +
> +jobs:
> +  create-gh-release:
> +    name: Create a new release or update an existing release in the GitHub repository
> +    runs-on: ubuntu-latest
> +    steps:
> +      - name: Checkout the repository
> +        uses: actions/checkout@v2
> +        with:
> +          fetch-depth: 2  # OR '0' To retrieve all preceding commit.

The value 2 seems pretty arbitrary and the comment adds nothing.

> +      - name: Get changed files
> +        uses: tj-actions/changed-files@v11.7
> +        id: changed-files

You've replied on Github that you need the last two commits for this 
action [3], but I don't think we care about wether or not the release 
notes where changed in the last commit. We only need the version number 
(from the pushed tag) to determine the correct release notes file.

> +        with:
> +          separator: ' '
> +      - name: Generate the changelog
> +        run: kotlin .github/scripts/generate-github-changelog.main.kts ${{ steps.changed-files.outputs.all_changed_and_modified_files }}
> +      - name: Create the release
> +        uses: actions/create-release@v1
> +        env:
> +          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
> +        with:
> +          tag_name: ${{ github.ref_name }}
> +          release_name: ${{ github.ref_name }}
> +          body_path: changelog.txt

If we just use the file directly we don't even need to copy the file to 
changelog.txt

> +          draft: false
> +          prerelease: false

If we don't exclude release candidates, we should set prelease to true for 
those tags.

>
> base-commit: 5f439a0ecfb4657100ec1e56ef9c6eca963b5a94
> -- 
> gitgitgadget
>

All in all I think this is too convoluted for what it's trying to 
achieve. I think we should be able to achieve the same result with 
something like this:

  .github/workflows/create-release.yml | 37 ++++++++++++++++++++++++++++
  1 file changed, 37 insertions(+)
  create mode 100644 .github/workflows/create-release.yml

diff --git a/.github/workflows/create-release.yml 
b/.github/workflows/create-release.yml
new file mode 100644
index 0000000000..5b9fdf0372
--- /dev/null
+++ b/.github/workflows/create-release.yml
@@ -0,0 +1,37 @@
+name: Create GH release
+
+# Create a GitHub release for each new tag.
+# The release notes are taken from the release notes file
+# modified in that commit located in Documentation/RelNotes directory.
+
+on:
+  push:
+    tags:
+      - v[0-9]+.[0-9]+.[0-9]+
+
+permissions:
+  contents: write
+
+jobs:
+  create-gh-release:
+    name: Create a new release or update an existing release in the 
GitHub repository
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout the repository
+        uses: actions/checkout@v2
+        with:
+          fetch-depth: 1
+      - name: Get version number
+        shell: bash
+        run: |
+          echo GIT_VERSION=${GITHUB_REF#refs/tags/v} >> $GITHUB_ENV
+      - name: Create the release
+        uses: actions/create-release@v1
+        env:
+          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
+        with:
+          tag_name: ${{ github.ref_name }}
+          release_name: ${{ github.ref_name }}
+          body_path: Documentation/RelNotes/${{ env.GIT_VERSION }}.txt
+          draft: false
+          prerelease: false
-- 
2.25.1

An example of the result this reduced action produces can be found at [4] 
(release notes for v2.34.1, but the tagged commit isn't v2.34.1).

Best regards

Matthias

[1] https://github.com/git/git/pull/1146
[2] https://github.com/git/git/pull/1146#discussion_r756854259
[3] https://github.com/git/git/pull/1146#discussion_r756845042
[4] https://github.com/rimrul/git/releases/tag/v2.34.1
