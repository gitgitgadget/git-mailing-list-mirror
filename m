From: Jonathan Nieder <jrnieder@gmail.com>
Subject: ks/precompute-completion
Date: Wed, 11 Nov 2009 16:08:32 -0600
Message-ID: <20091111220832.GA31620@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LDL-00055n-NK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759458AbZKKV6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 16:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759465AbZKKV6X
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:58:23 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53737 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759459AbZKKV6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:58:21 -0500
Received: by bwz27 with SMTP id 27so1532956bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zp8qnHX6ZXVMISbSJhzyMaAzSXZz9FrW1CouO5nfPz4=;
        b=YUxYrqtk6zLQ06zwG23PhKmIPcWXW94v8m6SckVThrQEXFGId0Xsn/fo1vnhr4yjgs
         fJEQBetU46XYEvOIrUvxsFFcpMMu2N3qbVr+zEOtbh/Wt611lup9Bbkb2x0WMqAegRvT
         MdDTn+GmDR8JANO4OlwKgo62A1qM6+HOdsZY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZNpOpJa9teNObQF+13unOZY2aR6gdL2c71RocfPmlfZuvWQpBKmIPHK+YzuKWz1sk5
         cMbWLayE3dY4qVcU9YB6BbTakFzipyNFDdhgj704MIkbajxKHeZuSFJRKpRXpMjpo2Mb
         Dlyi4+9Iq2uI5AVqleU9QZFNdewapK9rcbE5w=
Received: by 10.216.88.146 with SMTP id a18mr665583wef.56.1257976706021;
        Wed, 11 Nov 2009 13:58:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t12sm292288gvd.7.2009.11.11.13.58.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:58:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132710>

Hi,

>> * ks/precompute-completion (2009-10-26) 3 commits.
>> =C2=A0(merged to 'next' on 2009-10-28 at cd5177f)
>> =C2=A0+ completion: ignore custom merge strategies when pre-generati=
ng
>> =C2=A0(merged to 'next' on 2009-10-22 at f46a28a)
>> =C2=A0+ bug: precomputed completion includes scripts sources
>> =C2=A0(merged to 'next' on 2009-10-14 at adf722a)
>> =C2=A0+ Speedup bash completion loading
>>
>> What's the status of this thing? =C2=A0Last time I polled the list I=
 had an
>> impression that it was not quite ready...

As a distro user, I don=E2=80=99t think I would be able to use it until=
 there
is a command to update the installed completion, to call after adding
a new git command to my $PATH.  This could mean:

 - git-completion.bash.generate learns to read the .in file and
   write the completion script to arbitrary paths (or just always
   uses stdin and stdout?)

 - distros install git-completion.bash.{generate,in} to /usr/share/git-=
core

 - distros install a simple completion script to /etc/bash_completion.d
   that passes the buck, e.g.

-- %< --
# bash completion support for core Git.
#
# Run update-git-completion to generate these files.
#
__git_user_completion=3D~/.cache/git-core/git-completion.bash
__git_system_completion=3D/var/cache/git-core/git-completion.bash

if test -r "$__git_user_completion"
then
	. "$__git_user_completion"
elif test -r "$__git_system_completion"
then
	. "$__git_system_completion"
fi
-- >% --

 - new update-git-completion script, something like this:

-- %< --
#!/bin/sh
USAGE=3D"update-git-completion {--system | --user | <filename>}"
datadir=3D/usr/share/git-core
die() {
	echo >&2 "$*"
	exit 1
}

if ! test $# -eq 1
then
	die "usage: $USAGE"
fi

if test "$1" =3D "--system"
then
	output=3D/var/cache/git-core/git-completion.bash
elif test "$1" =3D "--user"
then
	output=3D$HOME/.cache/git-core/git-completion.bash
else
	output=3D$1
fi

rm -f "$output+" || die "cannot remove $output+"
sh "$datadir"/git-completion.bash.generate \
	< "$datadir"/git-completion.bash.in \
	> "$output+" || die "failed to generate completion script"
bash -n "$output+" || {
	rm -f "$output+"
	die "generated script fails syntax check"
}
mv -f "$output+" "$output" || {
	rm -f "$output+"
	die "failed to install completion script"
}
-- >% --

Thoughts?
