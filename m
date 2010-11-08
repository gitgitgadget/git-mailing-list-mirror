From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Mon, 8 Nov 2010 12:05:10 +0100
Message-ID: <201011081205.12191.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <201011041141.58334.jnareb@gmail.com> <AANLkTimxspcGLnv+F6uKAnFAhUO++iB10b5GxnLVg_v3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:05:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPXS-0004Z9-Ka
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab0KHLFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 06:05:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57695 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab0KHLFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:05:20 -0500
Received: by bwz11 with SMTP id 11so4670149bwz.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uRfW1D4Oyo1AswLabJ/gXMQBOtQo7ALv6f6ym9w7jS0=;
        b=pVKjwMwNVvho5960gxkNM2T/31+vwhXXbDf21c33QLBmGumBnwIo7lYj/F6MkxIHx7
         ukdg5gls/+uIJ/S1iTKCAyRl1+fPgNXD7oC8DVXTpY6XAxQNhURCkZAhdsggd67Hmx5w
         hliWrQ6nmxHoVRYMaeRPqD/V5iYKpMvaG8XWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=O+Bwe3rqY7e2lgGo04VnyvZ3Eno0r0aJjXYTjLghWjxFjW364k4OqIzIADiV7BBFZ6
         dk3VeYyC/am4xsKv+khK4tMJEIQZZkLxEhfU+jDDtkUAJQGeXDKDv6Him8yMrQxHfozD
         iFQfCOCbEUA+ft/GtPKIQlvl36+TfvnlNc2Tw=
Received: by 10.204.102.78 with SMTP id f14mr4820595bko.30.1289214318719;
        Mon, 08 Nov 2010 03:05:18 -0800 (PST)
Received: from [192.168.1.13] (abvu240.neoplus.adsl.tpnet.pl [83.8.218.240])
        by mx.google.com with ESMTPS id m8sm778333faj.3.2010.11.08.03.05.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 03:05:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimxspcGLnv+F6uKAnFAhUO++iB10b5GxnLVg_v3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160924>

On Mon, 8 Nov 2010, Giuseppe Bilotta wrote:
> On Thu, Nov 4, 2010 at 11:41 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Wed, 3 Nov 2010, Giuseppe Bilotta wrote:

>> I think remote_heads feature is more important for _local_ use, for
>> example browsing one own repository using git-instaweb. =A0In such c=
ases
>> number of remotes and of remote-tracking branches might be large (I =
have
>> 11 remotes, not all active, and 58 remote-tracking branches).
>>
>> BTW. would next version of this series include patch to git-instaweb
>> enabling 'remote_heads' feature for it (gitweb_conf function)?
>=20
> I will look into that.

It can be as simple as

diff --git i/git-instaweb.sh w/git-instaweb.sh
index e6f6ecd..50f65b1 100755
--- i/git-instaweb.sh
+++ w/git-instaweb.sh
@@ -580,6 +580,8 @@ gitweb_conf() {
 our \$projectroot =3D "$(dirname "$fqgitdir")";
 our \$git_temp =3D "$fqgitdir/gitweb/tmp";
 our \$projects_list =3D \$projectroot;
+
+$feature{'remote_heads'}{'default'} =3D [1]
 EOF
 }
=20

We might want to enable more features for git-instaweb, but I think
it would out of scope for planned commit (for 'remote heads' series).

>>> with all the remotes/<remotename> pathspecs as a single array
>>> argument. This _does_ mean that when the total number of remote hea=
ds
>>> is greater than the limit some remotes will not display complete
>>> information in summary view. The real issue here is, I think, that
>>> there is no trivial way to tell which remotes have incomplete
>>> information and which don't, meaning that in the subsequent
>>> git_remote_block calls we'll have no way to provide visual feedback
>>> (the ellipsis) when some heads are missing.
>>
>> Errr... shouldn't we leave limiting number of heads to fill_remote_h=
eads,
>> which can do limiting per remote (with each remote having up to $lim=
it
>> remote-tracking branches / remote heads), instead of having
>> git_get_heads_list do it?
>>
>> Something like this:
>>
>> +sub fill_remote_heads {
>> + =A0 =A0 =A0 my ($remotes, $limit) =3D @_;
>> +
>> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
>> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =
=3D~ s!^$remote/!! } @remoteheads ];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ @{$remotes->{$remote=
}{'heads'}}[0..$limit-1] ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (@{$remotes->{$remo=
te}{'heads'}}> $limit);
>> + =A0 =A0 =A0 }
>> +}
>>
>> Though perhaps it will be more clear with if as statement, not as mo=
difier:
>>
>> +sub fill_remote_heads {
>> + =A0 =A0 =A0 my ($remotes, $limit) =3D @_;
>> +
>> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
>> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =
=3D~ s!^$remote/!! } @remoteheads ];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (@{$remotes->{$remote}{'heads'}}> $=
limit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'h=
eads'} =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ @{$r=
emotes->{$remote}{'heads'}}[0..$limit-1] ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +}
>=20
> Either solution is fine, but it would require grabbing all the remote
> heads. The real issue here is, I think understanding what is the
> purpose of limiting in gitweb. Is it to reduce runtime? is it to
> reduce clutter on the screen? In the first case, the limiting should
> be done as early as possible (i.e. during the git call that retrieves
> the data); in the latter case, is it _really_ needed at all?

It is to reduce clutter on the screen, or rather have 'summary' view
for a project (for a repository) to be really a _summary_.  That's why
there is limit of 15 commits in shortlog, of 15 branches in heads, of
15 tags.  This action is meant to present balanced overview of=20
repository.


Regarding gitweb performance, it is quite important to pass limit to
git-log / git-rev-list needed also for 'summary' view; passing limit
to git command really matters here.

git_get_heads_list passes '--count=3D'.($limit+1) to git-for-each-ref,
but I don't think that it improves performance in any measurable way.
Similar with saving a memory: it is negligible amount.  So if we can
do better at the cost of running git_get_heads_list without a limit,
I say go for it.

Note that the costly part of git_get_heads_list is forking git command,
so it makes absolutely no sense to run git_get_heads_list once per
remote instead of doing limiting per-remote in Perl.  The former would
affect performance badly, I can guess.

--=20
Jakub Narebski
Poland
