Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62448C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 19:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJTAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJTAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 15:00:16 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 12:00:15 PDT
Received: from ma-mailsvcp-mx-lapp02.apple.com (ma-mailsvcp-mx-lapp02.apple.com [17.32.222.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A910C7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 12:00:14 -0700 (PDT)
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RSW0063BVC3Q330@ma-mailsvcp-mx-lapp02.apple.com> for
 git@vger.kernel.org; Mon, 10 Apr 2023 11:00:13 -0700 (PDT)
X-Proofpoint-ORIG-GUID: 8ggMhaDxgT1CS1wKWOhFCQmbKkO3Kg73
X-Proofpoint-GUID: 8ggMhaDxgT1CS1wKWOhFCQmbKkO3Kg73
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-04-10_13:2023-04-06,2023-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=HrWxU4kwQZsDw4qzAJnRBYdnAvxp7+2RNtzE01m4LtE=;
 b=ufoGb/Zsf75HnVW+tgNEqYHRhquqPAmMN8eJlUBZfaafSOwhwt5pJNfyj3QgUM5lEgpx
 74d8e/ANBBOhv/zIqpaoJ2Rof+d2h2sZhkY9Vf9svlTZQnx+UBPd1LUo5hZb/QP00Uee
 k+/F+mRcdGFFNUJs0/9Y4RUzcrPGnprjNPHzmL8SzH2YrmiLfTJ71+HyZ1K6WwYWzVOj
 I/pRlc4hvQDPhGyUaUjaRysuWRBD5/H2mOifHkR4729h+Wbso7mZ9rDiwEkQXXS3pwrJ
 3BDUxK8iNnx30bSvh6ZpUIyX98ypP0unpwRErDoHqS/RL4IsZcv4/GlYoSnG6TdhddNy 0A==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RSW00HWEVC90110@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Mon, 10 Apr 2023 11:00:09 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) id <0RSW00Q00V62F900@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 10 Apr 2023 11:00:09 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 012c018cc6ede09fb3721e56c38f9c29
X-Va-R-CD: 1728dd0c9a2af864cec29b861e04f773
X-Va-ID: edfdf156-489a-4079-8c01-46597a8fd0ab
X-Va-CD: 0
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 012c018cc6ede09fb3721e56c38f9c29
X-V-R-CD: 1728dd0c9a2af864cec29b861e04f773
X-V-ID: 6fa872f0-c30b-4c7e-bd10-13d123f965dc
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-04-10_13:2023-04-06,2023-04-10 signatures=0
Received: from smtpclient.apple (unknown [17.11.17.154])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023))
 with ESMTPSA id <0RSW00ADRVB08Y00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 10 Apr 2023 11:00:09 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.600.4\))
Subject: Re: [PATCH 1/2] subtree: support GPG commit signing
From:   Allen Reese <java.allen@apple.com>
In-reply-to: <ffbdcf9db686cdd786e21add6ca194c2dbdafa3b.1681146107.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 10:59:59 -0700
Cc:     Jacques Vidrine <t@fboundp.com>, apenwarr@gmail.com,
        Jacques Vidrine via GitGitGadget <gitgitgadget@gmail.com>
Content-transfer-encoding: quoted-printable
Message-id: <18BB0B7B-33C1-4B7F-ABC8-2A647E5B9497@apple.com>
References: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
 <ffbdcf9db686cdd786e21add6ca194c2dbdafa3b.1681146107.git.gitgitgadget@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Avery, as I don=E2=80=99t seem to have managed to cc Avery as =
part of the gitgadet pr.



> On Apr 10, 2023, at 10:01 AM, Jacques Vidrine via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20
> From: Jacques Vidrine <t@fboundp.com>
>=20
> Add support for -S/--gpg-sign/--no-gpg-sign command line options
> and commit.gpgsign configuration. These are passed to invocations
> of `git commit-tree`.
>=20
> Signed-off-by: Allen Reese <java.allen@apple.com>
> Signed-off-by: Jacques Vidrine <t@fboundp.com>
> ---
> contrib/subtree/git-subtree.sh  | 24 +++++++++++++++++++-----
> contrib/subtree/git-subtree.txt |  9 +++++++++
> 2 files changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/contrib/subtree/git-subtree.sh =
b/contrib/subtree/git-subtree.sh
> index 10c9c87839a..553b4391deb 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -46,6 +46,8 @@ rejoin        merge the new branch back into HEAD
>  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and =
'push --rejoin')
> squash        merge subtree changes as a single commit
> m,message=3D    use the given message as the commit message for the =
merge commit
> +S,gpg-sign?   GPG-sign commits, optionally specifying keyid.
> +no-gpg-sign   Disable GPG commit signing.
> "
>=20
> indent=3D0
> @@ -165,6 +167,7 @@ main () {
> 	arg_quiet=3D
> 	arg_debug=3D
> 	arg_prefix=3D
> +	arg_gpgsign=3D
> 	arg_split_branch=3D
> 	arg_split_onto=3D
> 	arg_split_ignore_joins=3D
> @@ -240,6 +243,9 @@ main () {
> 			test -n "$allow_addmerge" || =
die_incompatible_opt "$opt" "$arg_command"
> 			arg_addmerge_squash=3D
> 			;;
> +		-S*|--gpg-sign=3D*|--no-gpg-sign)
> +			arg_gpgsign=3D"${opt}"
> +			;;
> 		--)
> 			break
> 			;;
> @@ -268,6 +274,12 @@ main () {
>=20
> 	dir=3D"$(dirname "$arg_prefix/.")"
>=20
> +	if test -z "$arg_gpgsign" &&
> +		git config --bool commit.gpgsign >/dev/null
> +	then
> +		arg_gpgsign=3D"-S"
> +	fi
> +
> 	debug "command: {$arg_command}"
> 	debug "quiet: {$arg_quiet}"
> 	debug "dir: {$dir}"
> @@ -534,7 +546,7 @@ copy_commit () {
> 			printf "%s" "$arg_split_annotate"
> 			cat
> 		) |
> -		git commit-tree "$2" $3  # reads the rest of stdin
> +		git commit-tree $arg_gpgsign "$2" $3  # reads the rest =
of stdin
> 	) || die "fatal: can't copy commit $1"
> }
>=20
> @@ -674,10 +686,10 @@ new_squash_commit () {
> 	if test -n "$old"
> 	then
> 		squash_msg "$dir" "$oldsub" "$newsub" |
> -		git commit-tree "$tree" -p "$old" || exit $?
> +		git commit-tree $arg_gpgsign "$tree" -p "$old" || exit =
$?
> 	else
> 		squash_msg "$dir" "" "$newsub" |
> -		git commit-tree "$tree" || exit $?
> +		git commit-tree $arg_gpgsign "$tree" || exit $?
> 	fi
> }
>=20
> @@ -900,11 +912,13 @@ cmd_add_commit () {
> 	then
> 		rev=3D$(new_squash_commit "" "" "$rev") || exit $?
> 		commit=3D$(add_squashed_msg "$rev" "$dir" |
> -			git commit-tree "$tree" $headp -p "$rev") || =
exit $?
> +			git commit-tree $arg_gpgsign "$tree" \
> +			$headp -p "$rev") || exit $?
> 	else
> 		revp=3D$(peel_committish "$rev") || exit $?
> 		commit=3D$(add_msg "$dir" $headrev "$rev" |
> -			git commit-tree "$tree" $headp -p "$revp") || =
exit $?
> +			git commit-tree $arg_gpgsign "$tree" \
> +			$headp -p "$revp") || exit $?
> 	fi
> 	git reset "$commit" || exit $?
>=20
> diff --git a/contrib/subtree/git-subtree.txt =
b/contrib/subtree/git-subtree.txt
> index 004abf415b8..fa54541b288 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -185,6 +185,15 @@ subproject.
> --message=3D<message>::
> 	Specify <message> as the commit message for the merge commit.
>=20
> +-S[<keyid>]::
> +--gpg-sign[=3D<keyid>]::
> +--no-gpg-sign::
> +	GPG-sign commits. The `keyid` argument is optional and
> +	defaults to the committer identity; if specified, it must be
> +	stuck to the option without a space. `--no-gpg-sign` is useful =
to
> +	countermand both `commit.gpgSign` configuration variable, and
> +	earlier `--gpg-sign`.
> +
> OPTIONS FOR 'split' (ALSO: 'push')
> ----------------------------------
> These options for 'split' may also be given to 'push' (which wraps
> --=20
> gitgitgadget
>=20

