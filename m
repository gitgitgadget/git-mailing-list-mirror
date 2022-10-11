Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F63C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJKQzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJKQz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 12:55:29 -0400
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0778638479
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 09:55:26 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id 7B5B6FC438;
        Tue, 11 Oct 2022 12:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1665507325;
        bh=7eLg1VQl+j/Na4dPgJsHUD6aX75UlLqxnboe0yob4zI=;
        h=From:Subject:Date:References:To:In-Reply-To:From;
        b=iBOk0weiHwAkLA2yXvgUmPCVu5S8k4u1adapAj5jzC3wE6Bg9OsbYa1Nxegfj1Jz6
         wN2xpgw5/5h9pMH9YxPTlrAZWl4KcX5xL8J0csChDee0YXB25QShnVeQu1tr5MOznM
         GzW3qZjRrvH1jxFw9lS5fzcH3IdNOZAt36Yjg7Ohr3tejCsnuipRJ3i7YAW727qno8
         XyrGwJBk/GkkjrLOwDntWA4EDs6o5674EX8QBpegiRqKrsGaqhsq542kZ7e0BVGFru
         qq0sjkme1WA6K/Dos//1MMay15k1cIHPpdI4dTWjJFqLbNuUWncD0hBNqkNxLN1JKd
         uwxt/d6nZx68A==
From:   Elsie Hupp <git@elsiehupp.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: Multiple --global config workspaces?
Date:   Tue, 11 Oct 2022 12:55:24 -0400
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        reto@labrat.space, philipoakley@iee.email, git@vger.kernel.org
In-Reply-To: <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
Message-Id: <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Reto, Jeff, Philip, et al,

Cool, thanks!

I was using the =E2=80=9CGit Book=E2=80=9D documentation, not the =
manpage, since (a) the =E2=80=9CGit Book=E2=80=9D is more user-friendly, =
and (b) it=E2=80=99s higher on the DuckDuckGo results for =E2=80=9Cgit =
config", i.e.:

https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration

Even then, I don=E2=80=99t see includeIf in the first two web-based =
versions of the manpage for the DuckDuckGo query "man git-config":

https://linux.die.net/man/1/git-config
https://manpages.org/git-config

Though includeIf does appear in the manpage on my local system, as well =
as in the web-based Arch manpage (which is the fifth result):

https://man.archlinux.org/man/git-config.1

And includeIf does appear in the official documentation (which is the =
first DuckDuckGo result for "man git-config=E2=80=9D=E2=80=94I much =
prefer web mirrors to using man in the terminal):

https://git-scm.com/docs/git-config#_conditional_includes

So in summary it seems like a big part the issue I had is that the =
documentation for conditional includes has somewhat lacking SEO, i.e. if =
someone is familiar with the --global config keywords and googles that, =
they are unlikely to find the section for conditional includes. And, =
additionally, conditional includes are a new enough feature that they =
don=E2=80=99t appear in the higher-ranking web-based manpages, neither =
of which display the version of Git they pertain to. (Maybe someone =
could poke them about this, but I=E2=80=99m not sure the best way of =
doing so.)

As an aside, looking through the full documentation I see that I can =
also do:

[includeIf "hasconfig:remote.*.url:https://github.com/**=E2=80=9D] path =
=3D ./Repositories/github/.gitconfig
[includeIf "hasconfig:remote.*.url:https://gitlab.com/**=E2=80=9D] path =
=3D  ./Repositories/gitlab/.gitconfig

And, conveniently, [includeIf "gitdir:github/=E2=80=9C] also expands to =
[includeIf =E2=80=9Cgitdir:**/github/=E2=80=9C], so I don=E2=80=99t have =
to specify [includeIf "gitdir:~/Repositories/github/=E2=80=9C]. (I=E2=80=99=
m not sure how to represent the trailing slash in bash syntax, but it =
helps, too!)

Something more consistent with my initial use case might be a =
hypothetical feature like the following (apologies for dubious syntax):

[user "gitdir:github/"]
	email =3D "elsiehupp.github@example.com"

Or something like:

if "gitdir:gitlab/" email =3D "elsiehupp.gitlab@example.com=E2=80=9D

In other words, part of the discoverability issue is that I wasn=E2=80=99t=
 looking for a conditional _include_ so much as a conditional statement =
more generally.

I also tried:

[include] path =3D $GIT_COMMON_DIR/../.gitconfig

=E2=80=A6only to discover that $GIT_COMMON_DIR is not set automatically. =
Is there some way of automatically describing a path relative to any =
given cloned Git repository?

And I tried the following to no avail (despite both paths resolving when =
using cat):

[includeIf "gitdir:github/"] path =3D ./**/github/.gitconfig

[includeIf "gitdir:github/"] path =3D ./*/github/.gitconfig

So it would be nice if in addition to being able to use bash wildcards =
in [includeIf =E2=80=9Cgitdir=E2=80=9D] one could use bash wildcards in =
inclusion paths, as well.

I guess for the time being what I=E2=80=99ll stick with is this:

[includeIf "gitdir:github/"] path =3D ./Repositories/github/.gitconfig
[includeIf "gitdir:gitlab/"] path =3D ./Repositories/gitlab/.gitconfig

Best,
Elsie Hupp


> On Oct 11, 2022, at 9:56 AM, Philip Oakley <philipoakley@iee.email> =
wrote:
>=20
> On 11/10/2022 06:50, Junio C Hamano wrote:
>> Elsie Hupp <git@elsiehupp.com> writes:
>>=20
>>> I structure my cloned repositories based on the remote host, e.g.:
>>>=20
>>> ~/Repositories/github/cloned-repository-name
>>> ~/Repositories/gitlab/other-cloned-repository-name
>> The above is by definition not "global" (aka "per user").
>>=20
>> "--global" is for things that are of your personal preference, not
>> "when I am working on this project, these settings apply" (which is
>> suitable for "per repository").
>>=20
>> What you want is a way to say "when I am working on these projects,
>> these settings apply".
>>=20
>> One way to do this would be to have
>>=20
>> 	[includeIf "gitdir:~/Repositories/github/"] path =3D =
$HOME/.githubconfig
>> 	[includeIf "gitdir:~/Repositories/gitlab/"] path =3D =
$HOME/.gitlabconfig
>>=20
>> in $HOME/.gitconfig and then write in these two extra files that are
>> conditionally included whatever settings you want to use for any and
>> all repositories that come from GitHub or GitLab.
>>=20
>> $ git help config
>>=20
>> and look for Conditional includes, perhaps?
>>=20
>>=20
> This use of "IncludeIf" for the Home/work case also came up in a =
recent
> Git for Windows discussion
> https://github.com/git-for-windows/git/discussions/4058
>=20
> That discussion was about the trickiness of quoting when on the
> different Windows terminals/shells as the config string gets passed
> around (IIUC).
>=20
> --
> Philip



> On Oct 11, 2022, at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Elsie Hupp <git@elsiehupp.com> writes:
>=20
>> I structure my cloned repositories based on the remote host, e.g.:
>>=20
>> ~/Repositories/github/cloned-repository-name
>> ~/Repositories/gitlab/other-cloned-repository-name
>=20
> The above is by definition not "global" (aka "per user").
>=20
> "--global" is for things that are of your personal preference, not
> "when I am working on this project, these settings apply" (which is
> suitable for "per repository").
>=20
> What you want is a way to say "when I am working on these projects,
> these settings apply".
>=20
> One way to do this would be to have
>=20
> 	[includeIf "gitdir:~/Repositories/github/"] path =3D =
$HOME/.githubconfig
> 	[includeIf "gitdir:~/Repositories/gitlab/"] path =3D =
$HOME/.gitlabconfig
>=20
> in $HOME/.gitconfig and then write in these two extra files that are
> conditionally included whatever settings you want to use for any and
> all repositories that come from GitHub or GitLab.
>=20
> $ git help config
>=20
> and look for Conditional includes, perhaps?


> On Oct 11, 2022, at 1:51 AM, Reto <reto@labrat.space> wrote:
>=20
> That already exists, git-config(1), look for "Conditional includes"
> That way you can do it per top level folder or whatever makes sense =
for
> you.
>=20
> Examples:
>=20
> ; include for all repositories inside /path/to/group
> [includeIf "gitdir:/path/to/group/"]
> 	   path =3D /path/to/foo.inc
>=20
> ; include for all repositories inside $HOME/to/group
> [includeIf "gitdir:~/to/group/"]
> 	   path =3D /path/to/foo.inc


> On Oct 11, 2022, at 9:13 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Oct 10, 2022 at 10:50:22PM -0700, Junio C Hamano wrote:
>=20
>> One way to do this would be to have
>>=20
>> 	[includeIf "gitdir:~/Repositories/github/"] path =3D =
$HOME/.githubconfig
>> 	[includeIf "gitdir:~/Repositories/gitlab/"] path =3D =
$HOME/.gitlabconfig
>>=20
>> in $HOME/.gitconfig and then write in these two extra files that are
>> conditionally included whatever settings you want to use for any and
>> all repositories that come from GitHub or GitLab.
>=20
> I was about to write the same response. :) One small correction, =
though:
> we don't expand $HOME in include paths. You can use "~", but easier
> still is that non-absolute includes are relative to the including =
file.
> Relative paths in includes are relative to the including file. So you
> can just write ".githubconfig", etc, and we'll expect them adjacent to
> $HOME/.gitconfig (or the xdg path if you use that, I guess).
>=20
> -Peff

