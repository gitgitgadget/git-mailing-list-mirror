From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [StGit PATCH 0/4] --diff-opts in config file
Date: Thu, 24 Jan 2008 15:20:13 -0500
Message-ID: <9e4733910801241220j5a470d12s3378d338797e01be@mail.gmail.com>
References: <20080124074827.GA29572@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20080124075935.25525.24416.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Yann Dirson" <ydirson@altern.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI8Z9-0004Nr-KH
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 21:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYAXUUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYAXUUS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 15:20:18 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:7308 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYAXUUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 15:20:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so591868wah.23
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Bt1MtlhViX7gyUMc+5ikuoQ6iLCRpL6UzxyqLlkeO+Y=;
        b=bUaF5iyJN/HIK2G89k8MtIKcDdpcZFr9icj3+RwQ5uG36xdfpR8i42HyEwvD1tJASqUU2AZKB+oR15XBbaarVkMrgn4aE8xl9+a7D6EwBxi8hodtkYTfMQ1iXvNiV4kQFaSOKQTdQlmyza9whxYBn+F1FPPqa0juRZWkZn9wKdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f8K8vMYQCafsxRPkcckCwe5WdWqw2+WnHRczsfbgZYF0pBZN89MJWUIWUWl69qeHcSL1Snpmzg68CuypB24IOPRDta8ikL1hp5YH12ddZMqa5Sa5DWMjvFT05PLx+mHYIPYl+HX7tMl4y5DEowUxXraV3xAxddwTjd3P5n63ml8=
Received: by 10.115.90.1 with SMTP id s1mr1286252wal.41.1201206013317;
        Thu, 24 Jan 2008 12:20:13 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Thu, 24 Jan 2008 12:20:13 -0800 (PST)
In-Reply-To: <20080124075935.25525.24416.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71657>

On 1/24/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This is first two cleanup patches, followed by one patch that makes
> "stg show" handle diff options like the other commands, and last a
> patch that reads diff opts from the config file.
>
> The first two patches are in kha/safe, but the latter two are in
> kha/experimental because -- as Yann pointed out -- it's good to make
> sure the design is OK before committing to it.
>
> I've solved the problem of overriding the config on the command line
> by making --diff-opts=3D'--foo --bar' _add_ options, and special-case=
d
> --diff-opts=3D'' to clear all options, including those from the confi=
g
> file, since appending no options makes no sense.
>
> We'll still have to consider if and how to support different options
> for different tools.
>
> Oh, and Jon: is this what you wanted, by the way? :-)

This patch series is fine for my uses.

>
> ---
>
> Karl Hasselstr=F6m (4):
>       Read default diff options from the user's config
>       Let "stg show" use the unified --diff-opts handling
>       Refactor --diff-opts handling
>       Remove unused default values
>
>
>  examples/gitconfig       |    4 ++++
>  stgit/commands/diff.py   |   14 ++++----------
>  stgit/commands/edit.py   |   14 +++-----------
>  stgit/commands/export.py |   12 +++---------
>  stgit/commands/files.py  |   13 ++++---------
>  stgit/commands/mail.py   |   12 +++---------
>  stgit/commands/show.py   |   13 ++++---------
>  stgit/commands/status.py |   17 +++++------------
>  stgit/utils.py           |   13 +++++++++++++
>  9 files changed, 43 insertions(+), 69 deletions(-)
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
