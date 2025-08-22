Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71991298991
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887264; cv=none; b=gx9wbGF2Iybvw18POMzQ2ZKwHHt2hTCOl7Azwhnos1ZozWL8aH5LnOZIM7BcfI4k1BxbsXBPshKWvRLAm12zXRnwmsuctskYFofGIvJSlx+rqpYNRTQWwzU09ggZVGsCZ3VJKJwscwNeROKqpX+/BaK4oL/E3PBYRqXXCFqEF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887264; c=relaxed/simple;
	bh=joMmimzjEM4FfK5vteJcjOHcy6nvdZypaxNNmUtnWj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=EKsD70/mh9DsupCxKQSlqoXd64QUU5SawWl/hBzPwttPxFd6DBbEdNSehvHwxfVclDpZ4JY8BoN7nUfDkFxzZ0H/8phHRO9fD3+iUvyjmWbQDEdYGyP2elWByG7VtCw0MXIGyiBq/owjV52ITNhUXct2yVocLDliOMELZCuKw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4c7pZX61LdzRnmF;
	Fri, 22 Aug 2025 20:27:32 +0200 (CEST)
Message-ID: <cef6487f-aab4-421e-ba04-a5613c12e552@kdbg.org>
Date: Fri, 22 Aug 2025 20:27:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitk: add README with usage, build, and contributing
 details
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250821222605.3993-1-rappazzo@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250821222605.3993-1-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.08.25 um 00:25 schrieb Michael Rappazzo:
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> Changes from v1:
>  - Added Usage section with basic gitk command examples
>  - Simplified Contributing section by removing detailed patch workflow instructions
>  - Removed repository status and integration details

Thank you very much, this looks a lot better!

> 
>  README.md | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 README.md
> 
> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000000..fd249bc24d
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,61 @@
> +# gitk - The Git Repository Browser

Can we please write "Gitk" (uppercase "G") when we talk about the
software, not the command?

I would prefer an easy to read text file. Can we have underlined headers
where possible:

Gitk - The Git Repository Browser
=================================

Analogously for the subordinate headers below.

> +
> +gitk is a graphical Git repository browser. It displays the commit history of a Git repository as a graph, showing the relationships between commits, branches, and tags.
Please wrap the lines so that they don't exceed, say, 70 positions.

> +
> +## Usage
> +
> +To view the history of the current repository:
> +```bash
> +gitk
> +```
> +
> +To view the history of specific files or directories:
> +```bash
> +gitk path/to/file
> +gitk path/to/directory
> +```
> +
> +To view a specific branch or range of commits:
> +```bash
> +gitk branch-name
> +gitk v1.0..v2.0
> +```
> +
> +For more usage examples and options, see the [gitk manual](https://git-scm.com/docs/gitk).
> +
> +## Building
> +
> +gitk is a Tcl/Tk application. It requires Tcl/Tk to be installed on your system.
> +
> +### Running directly

At this point we should insert:

    Gitk can be run from the source directory without installation:

> +```bash
> +./gitk
> +```

    This is very convenient during development.

> +
> +### Installation
> +To install system-wide, you can use either `make` or `meson`:
> +
> +```bash
> +# Using Make
> +make install

This doesn't install system-wide, but in $HOME/bin. I am unsure whether
we should encourage this. AFAIC, I would be upset if this works without
sudo *and* clutters my $HOME. (I pull Gitk into the Git repository,
which I have patched to install in /usr/local.)

How do Gitk contributors handle `make install`?

> +
> +# Using Meson
> +meson setup builddir
> +meson compile -C builddir
> +meson install -C builddir
> +```

I haven't used the Meson infrastructure ever. I trust this procedure works.

> +
> +Both build systems will handle setting the correct Tcl/Tk interpreter path and installing translation files.
> +
> +## Contributing
> +
> +Contributions are welcome! The preferred method for submitting patches is via email to the Git mailing list, as this allows for more thorough review and broader community feedback. However, GitHub pull requests are also accepted.
> +
> +All commits must be signed off (use `git commit --signoff`) and should have commit messages prefixed with `gitk:`.
> +
> +#### Email Patches
> +Send patches to git@vger.kernel.org and CC j6t@kdbg.org. See the Git project's [patch submission guidelines](https://git-scm.com/docs/SubmittingPatches) for detailed instructions on creating and sending patches.
> +
> +## License
> +
> +gitk is distributed under the GNU General Public License, either version 2, or (at your option) any later version.

Very good!

-- Hannes

