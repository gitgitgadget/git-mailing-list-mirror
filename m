Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857138;
	b=HzAv3cWQ+7WM51BqU4OXiB0KryG/IhaogkOv/e6yvbScozac58GgYn2XMsUJGEdGwxJt
	 XdxpHTRRPrG01pDv8QyW+CKSq/FeyL1pJNPNGifYLyU7wL2KD9EfVJftR/8T8j3Wa3p31
	 PY/Faj3S0kbRk0gkvXSWr4/G8lCDB1IkqfQ4P2QZumXkgjrB2Jpwpf416J3CKu11zZ6MZ
	 0LYgdc2b1fwxpLAOU5CGHzvyiqat23Fz6aUKm70Kb/B86FQWM5rAjCyXqc/VHuEScCCHQ
	 XEslBQX3hSWjyR+avb4ADOveTrvj7ZQVkLAzuLDHq32FObi6JJhVkri/weHzyMoj5NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857138;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:Cc:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ddXhbAuMi8HsiiqzeUidvRa37cVXcGe6nsh/kyE8lzU=;
	b=4b4DX94rBXt/B+bPDhGMaOrpYHYOx2V+qXYYCSRwf8w8X+EUvjOiFD3aIYL5E3+2ja05
	 vfQOYUO//QqBX8BALaIPCicE/sPYC400hg27NVcbz4LQpy3icqKY8yxqe39hO0ypejCXQ
	 sn7pYNV2QFeDZJZMG5EGHhHadCUuL4LAnCm/y8skkMdlQy5Zx/svM9Ut5oYSw5zwzn6go
	 MZq2s72dJ2WxZpQYQmpZGKO6+jYZ7KUj5vm7TPYeXBxrX9ES/zhVFOIP2H5Y2m9UGSSgq
	 yhZpG4cqajv8+pxCMGFWx2TK8QBMpppQ+hT7dEMhDFkezuHxUUxkIKARXY4V4+Er2OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.17
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AD606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 646AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4jBksh17tGzRnD5;
	Sat, 24 Oct 2026 17:52:08 +0200 (CEST)
Message-ID: <75b5e0d7-9608-4e2f-a60c-d278af5b2e85@kdbg.org>
Date: Sat, 24 Oct 2026 17:52:07 +0200
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add cherry-pick -x context menu action
To: Ralf Habacker <ralf.habacker@freenet.de>
References: <84e29b80-e219-44ed-b98a-b224d7c264d6@freenet.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <84e29b80-e219-44ed-b98a-b224d7c264d6@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please paste the contents of the format-patch output into the email; do
not send it as attachment. See the format-patch man page[1] how to set
up a mail client in a way that does not mangle the patch text.

[1] https://git-scm.com/docs/git-format-patch#_mua_specific_hints

Am 24.10.26 um 11:40 schrieb Ralf Habacker:
> For example, this command is very useful for cherry-picking
> commits into a stable branch using a reference—something that

We need an en-dash or em-dash (two or three dashes) between "reference"
and "something" to give the sentence the correct meaning.

> otherwise can only be done from the command line.
> 

Personally, I use cherry-pick -x so rarely that I have no problem going
to the command line for those cases. Since the context menu is already
very long, I am hesitant to add a small variation of a command that is
already present (and very useful).

Are others interested in this feature?

Below some comments on the implementation just in case there are.

> Signed-off-by: Ralf Habacker <ralf.habacker@freenet.de>
> ---
>  gitk-git/gitk        | 15 ++++++++++-----
>  gitk-git/po/bg.po    |  3 +++
>  gitk-git/po/ca.po    |  3 +++
>  gitk-git/po/de.po    |  3 +++
>  gitk-git/po/es.po    |  3 +++
>  gitk-git/po/fr.po    |  3 +++
>  gitk-git/po/hu.po    |  3 +++
>  gitk-git/po/it.po    |  3 +++
>  gitk-git/po/ja.po    |  3 +++
>  gitk-git/po/pt_br.po |  3 +++
>  gitk-git/po/pt_pt.po |  3 +++
>  gitk-git/po/ru.po    |  3 +++
>  gitk-git/po/sv.po    |  3 +++
>  gitk-git/po/ta.po    |  3 +++
>  gitk-git/po/vi.po    |  3 +++
>  gitk-git/po/zh_cn.po |  3 +++

Please do not edit the translation files.

>  16 files changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9506739c50..5d9c781778 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2859,6 +2859,7 @@ proc makewindow {} {
>          {mc "Write commit to file" command writecommit}
>          {mc "Create new branch" command mkbranch}
>          {mc "Cherry-pick this commit" command cherrypick}
> +        {mc "Cherry-pick this commit with -x" command {cherrypick 1}}

We are in a UI here. Avoid jargon. ("What is -x??") How about:

	"Cherry-pick with cross-reference"

>          {mc "Reset HEAD branch to here" command resethead}
>          {mc "Mark this commit" command markhere}
>          {mc "Return to mark" command gotomark}
> @@ -9167,13 +9168,13 @@ proc rowmenu {x y id} {
>      if {$id ne $nullid && $id ne $nullid2} {
>          set menu $rowctxmenu
>          if {$mainhead ne {}} {
> -            $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
> +            $menu entryconfigure 9 -label [mc "Reset %s branch to here" $mainhead] -state normal
>          } else {
> -            $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
> +            $menu entryconfigure 9 -label [mc "Detached head: can't reset" $mainhead] -state disabled
>          }
> -        $menu entryconfigure 10 -state $mstate
>          $menu entryconfigure 11 -state $mstate
>          $menu entryconfigure 12 -state $mstate
> +        $menu entryconfigure 13 -state $mstate
>      } else {
>          set menu $fakerowmenu
>      }
> @@ -9881,7 +9882,7 @@ proc exec_citool {tool_args {baseid {}}} {
>      array set env $save_env
>  }
>  
> -proc cherrypick {} {
> +proc cherrypick {{withx 0}} {

If you make the default value of the parameter "-r", then the new caller
can just pass "-x" and we do not need the conditional below. (Also
rename the parameter.)

>      global rowmenuid curview
>      global mainhead mainheadid
>      global gitdir
> @@ -9898,7 +9899,11 @@ proc cherrypick {} {
>      update
>      # Unfortunately git-cherry-pick writes stuff to stderr even when
>      # no error occurs, and exec takes that as an indication of error...
> -    if {[catch {safe_exec [list sh -c "git cherry-pick -r $rowmenuid 2>&1"]} err]} {
> +        set xopt ""
> +    if {$withx} {
> +        set xopt " -x"
> +    }
> +    if {[catch {safe_exec [list sh -c "git cherry-pick -r$xopt $rowmenuid 2>&1"]} err]} {

-r and -x are opposites. While the last one wins, it would be great if
the one option that is not used would not remain in the command.

>          notbusy cherrypick
>          if {[regexp -line \
>                   {Entry '(.*)' (would be overwritten by merge|not uptodate)} \

-- Hannes

