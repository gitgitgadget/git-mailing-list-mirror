Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F71E98E7
	for <git@vger.kernel.org>; Fri, 23 May 2025 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043877; cv=none; b=t7qIssmUqdHXQjAttL7rJfgW+B9bR4HbIpd8X3VD7+w8rx0hwVpa803H14wnaIT0NL7UOO2yE1DG82PqqESs9poSedX4fdDmjcW09uWja4hWEaFd3CHhFdOcGjJQd8Ok3NIolW+4+3ZSzeEGbT6c7t1V2NrWo2/HOqrr6OdRC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043877; c=relaxed/simple;
	bh=Y2ebPqu4dsjE4dl60cjDgsD3X6RQdJzxtTIOmh+RF5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i2bJksvW4uGE3w+HsqYAKUPJ+9sUWqLuY6dPSN65AdKo856+K2QmzdUKBHARN583DUZug7W22Ea8k9N1BKjBAJZ1LwPch0Ghpb5y1NTI6cL7DQsETvgjapvDTYt+9v5dgKzprmYyBzs+dLJ5WejGMvg+9kSfplPqa7aSFW5bY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JQC411yI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccK7g6ET; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JQC411yI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccK7g6ET"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E88A911400F5;
	Fri, 23 May 2025 19:44:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 19:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748043874; x=1748130274; bh=o7FEwH7YS7
	OjAQg24AdVbtqeZcseXdY79HHlv1WmSzE=; b=JQC411yI5UO7QK3bRHLHWgiZo+
	jFwUbvLZ1otf8lRXE+2lgeCUsKzP/Kary4DO15T8JN9xkgBbSDQMUcwEYUVAw7U1
	nZPT2JW8elRGBH91sn9UN/TK4eCol0fFH1odfkHjoR1qr/ooUxFwP5hBIlN7a8pg
	nBeC0E6DEsDopE4kcGg3DRCKemRhbXXioWkHxVLtnz0t2lTAngyuaUxrjwKd1dzd
	3Icv5Jt3acN7DoOlXjHVEio1H+IJOCAktZzi1L5iXFIvmsTqWdVvoeedh1JLqwdP
	0gfvkG4jHTBrtprNz5AZB0MYy5JupG5FjpJJFySf/MHJM4dTHsg5uJ8+xBaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748043874; x=1748130274; bh=o7FEwH7YS7OjAQg24AdVbtqeZcseXdY79HH
	lv1WmSzE=; b=ccK7g6ETAOefYzEHRb7KZ/Ir3m6mG4k+bpYvDS0xOsSN+N+CB3i
	cKymJSIfCni1YZDw72jFkHo9nPPiy/GuT+YQQSDfkxuk9t4k+Mi+X5DBej2YAkwv
	C1RtxS3TsuI7kKEdmWUjgWqjvi3Lx/htEmXsWa6OYhd5+ApOfOkZd2iNI1qE9hni
	oXizwAgxGPvxW57h2YrC2LamYzOl7glJSBzRWj8Wx3mdoB6FN4NS6zeJzLM11SDA
	YRnciqbk3WOhlWtj09XubhnB+CpANq20k+fNKh3+yhWdr/Yhp3MKPlcJMWaclPfi
	yh2gybOekLZKvrSGqbmq6Mnk+4M1e45QDKA==
X-ME-Sender: <xms:YggxaGq3rhH7385k5jmug8R0ATWTPomAUcNef-FaQ7pc6zFaKzhYCg>
    <xme:YggxaEpw28lQCIOIZQUQTX8jbtoxXCy9n3tMt1foQQjHn1XUzK8febb_zrb4KHHvC
    vTuo8Czzu6MK0lbWA>
X-ME-Received: <xmr:YggxaLOj6cA2ScF0Aet9Wejb0Xh7hA2rxsudrxJ1TsYVAcFfTeW_kjKukzFpzGvSPzxUlgOGwpOhPun2qZARV3VKDkE-h6mLGClq2Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddvtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfe
    ehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:YggxaF7xdHRXUESJUW0tiPhQNLR5CVHnvCQ8voY2rDFK_zoY2Sd29A>
    <xmx:YggxaF79kOmECo_gghkELnHylSwZbJ1cdNFAlna5qUa9Kxp-ASNaig>
    <xmx:YggxaFjx7E3iKoQ0sqFFYxBhIs77Fc61iOpwjwX9u9mqW_U-Osoorw>
    <xmx:YggxaP5jdU4NL0byFHoXGUM9JPQcQRgc2xGmHCO9clq_NIIv7syiJQ>
    <xmx:YggxaArGPxZKMJJ2UfLk3yYQoKdQrmquexVTuVKi5NYwtHzQvOxlUaUl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 19:44:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/2] apply: set file mode when --reverse creates a
 deleted file
In-Reply-To: <20250523172154.93810-3-mark@chromium.org> (Mark Mentovai's
	message of "Fri, 23 May 2025 13:21:54 -0400")
References: <20250522220235.8650-1-mark@chromium.org>
	<20250523172154.93810-1-mark@chromium.org>
	<20250523172154.93810-3-mark@chromium.org>
Date: Fri, 23 May 2025 16:44:33 -0700
Message-ID: <xmqqbjrivqn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> +test_file_mode_common() {

Unlike the two callers, this lacks SP before "()".

I would have expected that "no such file" would be expressed with
mode 000000 (taken from "git diff --raw" for a removal/creation
patch), but an empty string works just as well.  The same comment
about requiring 0-prefix before 644 and 755 applies here, but as
long as it is done consistently, I wouldn't complain too loudly ;-)

> +	test -n "$1" && test_grep "^10$1 " "$2" || test_must_be_empty "$2"
> +}
> +
>  test_file_mode_staged () {
>  	git ls-files --stage -- "$2" >ls-files-output &&
> -	test_grep "^10$1 " ls-files-output
> +	test_file_mode_common "$1" ls-files-output
>  }
>  
>  test_file_mode_HEAD () {
>  	git ls-tree HEAD -- "$2" >ls-tree-output &&
> -	test_grep "^10$1 " ls-tree-output
> +	test_file_mode_common "$1" ls-tree-output
>  }
>  
>  test_expect_success 'git apply respects core.fileMode' '
> @@ -180,6 +184,150 @@ test_expect_success 'git apply warns about incorrect file modes' '
>  	test_file_mode_HEAD 0755 mode_test
>  '
>  
> +test_expect_success 'setup: git apply [--reverse] restores file modes (change_x_to_notx)' '
> +	test_config core.fileMode false &&
> +
> +	touch change_x_to_notx &&
> +	git add --chmod=+x change_x_to_notx &&
> +	test_file_mode_staged 0755 change_x_to_notx &&
> +	test_tick && git commit -m "add change_x_to_notx as executable" &&
> +	test_file_mode_HEAD 0755 change_x_to_notx &&
> +
> +	git add --chmod=-x change_x_to_notx &&
> +	test_file_mode_staged 0644 change_x_to_notx &&
> +	test_tick && git commit -m "make change_x_to_notx not executable" &&
> +	test_file_mode_HEAD 0644 change_x_to_notx &&
> +
> +	git rm change_x_to_notx &&
> +	test_file_mode_staged "" change_x_to_notx &&
> +	test_tick && git commit -m "remove change_x_to_notx" &&
> +	test_file_mode_HEAD "" change_x_to_notx &&
> +
> +	git format-patch -o patches -3 &&
> +	mv patches/0001-* change_x_to_notx-0001-create-0755.patch &&
> +	mv patches/0002-* change_x_to_notx-0002-chmod-0644.patch &&
> +	mv patches/0003-* change_x_to_notx-0003-delete.patch &&
> +
> +	test_grep "^new file mode 100755$" change_x_to_notx-0001-create-0755.patch &&
> +	test_grep "^old mode 100755$" change_x_to_notx-0002-chmod-0644.patch &&
> +	test_grep "^new mode 100644$" change_x_to_notx-0002-chmod-0644.patch &&
> +	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch
> +'

OK.

> +test_expect_success 'git apply restores file modes (change_x_to_notx)' '
> +	test_config core.fileMode false &&

Wouldn't this and the subsequent tests want to begin with 

	git reset --hard <commit> &&

to a known good state?  We expect that after successfully running
this test piece, for example, the path is removed after the last
patch that removes change-x-to-notx is applied.

If this one failed, and if the tester is not running the test with
"-i", the index and the working tree state left by failure of this
step would cause the next test start in a state that it is not
expecting.  For example, if this one failed after applying
change-x-to-notx but while applying change-x-to-notx again (perhaps
it did not see the right message), the step to apply the deltion
patch is skipped.  The next test wants to reverse apply the deletion
patch, which means it wants the path not to exist, but if this test
fails in the middle, that is not guaranteed.

The same comment applies to later ones, as well.

Other than that, we seem to have a very good coverage of the
combinations now.  Thanks for a thorough work.

