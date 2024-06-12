Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBD3209
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217526; cv=none; b=fHCvn32wnJUXI4BwtoL3SOmyqloT3r7/i0VpDvF/ipnB9m7eGThF7vs7AcL/q72Z8XBPyCdT9xu09WgspW74qpBsoXNiqX6GSg6F+W8jRNQWwp0umKWTLwhpP7kpt6IgUY6Aejp67/GcNZsl3L6+tJmGjxGot37pyN9+rOc4rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217526; c=relaxed/simple;
	bh=8ZLwffB5GM97Q87VOAxK7ZEdjCVh6q1v+PvJsidPsc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlnIDvQoodB0Kge+ENW7ggVPsCGCxWR4Rf96wq1WfLY02vTV+4owVcc8Fy4NXOUNcflTUAOkOmhdMm99UDx16iK6YjyKIAXHuOZxavE1rnjlUlOIfATH9Kd4Ajd+o9/hV3wAqzHipD6j/NQc/SfX8XFCxbmfEH5YzTOUHXeNJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Duwswdl; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Duwswdl"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9794dad09so110019eaf.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217523; x=1718822323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5zabzevass76lG87MqzwgznW2WQfxE5Vhw80otYPzw=;
        b=4DuwswdllvAZxoMRFzU/XmysxFU7ZDRtC5cGXwQKjqg/0uwNgXC4c4U4ngIAlVKAKc
         YZhMTvyt33JbTBSIkKB2dfwxmB84fumlKwWMUUViDP1hDNN8+IwH56KlJh4s71vjr0Nw
         ui1MTMtB/jrT5JUilBYOHcTxaA6me7HKXwvz89E9ii80XPzNCJWu4KpPT/TpCf/N+u8M
         cA38kL4lOWC9W91zNeSL/MQi9vDej4BHK14dZ0WRSqZmiLxhWOxC3ejOBrw5fItB0Lt1
         DvaaNDW9aENBT6W6Sc/HJ9b6/EmQe0vjJhqkilYAHD2KEgShYTb2Uu5q4TvHGxv+jl9i
         C2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217523; x=1718822323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5zabzevass76lG87MqzwgznW2WQfxE5Vhw80otYPzw=;
        b=G311vy1Hbvh+5b16NqHVpq98KjPHJNs1cXP/ywwHGON45c+YAcaj8VGU0DY5pEWEyl
         a46ASa6Qkwp6G71ucB6h11FHdk8lR7NhyXlvzXvssZ3HHAY4gcUsqtpEHB+aacSqI1kI
         HR6dtvnIq50/sl4cn35z9NySC0nJikiTR8EHb8q5kRHRH4Ln/+SLVoW5cixnGJba24UM
         4YNKlIo/ryyfbqX4ZuX9n+Oe+apJFZQu0nb9+Lh1kHOFKKpwcMXd/3ViUZNd9LSU7QQx
         5lbnnAhEQB6D2+WUFGmgnSBD/mFnUKAMwuirB0z5OJ1cHsj1arMfE9QN6GpZ3Pw98uVz
         AkpQ==
X-Gm-Message-State: AOJu0YxRFjz/7H17KE1IGWXZQgl0GYAT3Us9akXG2CoQk/1mf62iz6kT
	jEC/2AtvZsw0CBssRuFS4fQL0e4jSmRchHF1x6HbJBcVVjrIJptYAJvm4JhumS+OQoE5W1gYvhY
	3RibYZMfaBAP4kj6QN0LPm7nlXABRU1iVO+hfxhLimRO+nGipfpCY
X-Google-Smtp-Source: AGHT+IFzv4oHsh4yp5CMKn9m5ofp1x8XgIVyJud+hIKv1Usjsp/2lJziQQptf3L41oTxWEzeI5TnyqisL4q73VR26QU=
X-Received: by 2002:a05:6820:16a0:b0:5ba:ef23:7011 with SMTP id
 006d021491bc7-5bb3ba14d68mr3266039eaf.4.1718217523144; Wed, 12 Jun 2024
 11:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqr0d2p1x3.fsf@gitster.g>
In-Reply-To: <xmqqr0d2p1x3.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 12 Jun 2024 11:38:30 -0700
Message-ID: <CAO_smVh2yZRfs2vq2RKY=eLj8-0BgPierxksq376u=X-=pbKWA@mail.gmail.com>
Subject: Re: [RFH] t9500 failing???
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 9:23=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Suddenly t9500.70 has started failing for me in my local environment
> (but $Corp IT folks control pretty much which version of base software
> is installed and updated at what time, once I choose "I want to do CGI
> in Perl" by selecting the libcgi-pm-perl module, I am not sure from
> which version the thing was updated from.  The Debian version claims
> to be 4.62-1.

I have the same version (I'm on the same $Corp IT setup). I downgraded
to 4.61 and it succeeded. Upgraded to 4.62 again, and it started
failing. The only difference in 4.62 besides a version number change
in several files is:

```
diff -ur 4.61/usr/share/perl5/CGI.pm 4.62/usr/share/perl5/CGI.pm
--- 4.61/usr/share/perl5/CGI.pm 2024-01-08 07:13:22.000000000 -0800
+++ 4.62/usr/share/perl5/CGI.pm 2024-03-01 05:43:03.000000000 -0800
@@ -1,13 +1,14 @@
 package CGI;
 require 5.008001;
 use Carp 'croak';
+use URI;

 my $appease_cpants_kwalitee =3D q/
 use strict;
 use warnings;
 #/;

-$CGI::VERSION=3D'4.61';
+$CGI::VERSION=3D'4.62';

 use CGI::Util qw(rearrange rearrange_header make_attributes unescape
escape expires ebcdic2ascii ascii2ebcdic);

@@ -2747,8 +2748,10 @@
     $url .=3D $path         if $path_info and defined $path;
     $url .=3D "?$query_str" if $query     and $query_str ne '';
     $url ||=3D '';
-    $url =3D~ s/([^a-zA-Z0-9_.%;&?\/\\:+=3D~-])/sprintf("%%%02X",ord($1))/=
eg;
-    return $url;
+
+ $url =3D URI->new( $url )->canonical;
+ $url =3D~ s!/$!!;
+ return $url
 }

 #### Method: cookie
```

I can confirm that backing that out fixes the issue. I also don't know
enough perl to know what's wrong with that statement, but looking at
the current head version, my guess is that it's the wrong type. The
current head version
(https://github.com/leejo/CGI.pm/blob/89c51a088db2a45b1c759e02c8d4772f5b6a3=
6a9/lib/CGI.pm#L2752)
has `$url =3D URI->new( $url )->canonical->as_string;`, applying that
patch locally makes this work again. Running blame points us at
https://github.com/leejo/CGI.pm/issues/263 ("->url being a object
breaks everything"). One person even references this gitweb.perl
breakage in the issue comments :)

So my conclusion is that 4.62 is broken, and that newer versions are unbrok=
en.

>
> It fails with path-info test, starting at t9500.70 with extra
> warning in the log.  This code
>
>         if ($path_info) {
>                 # $path_info has already been URL-decoded by the web serv=
er, but
>                 # $my_url and $my_uri have not. URL-decode them so we can=
 properly
>                 # strip $path_info.
>                 $my_url =3D unescape($my_url);
>                 $my_uri =3D unescape($my_uri);
>                 if ($my_url =3D~ s,\Q$path_info\E$,, &&
>                     $my_uri =3D~ s,\Q$path_info\E$,, &&
>                     defined $ENV{'SCRIPT_NAME'}) {
>                         $base_url =3D $cgi->url(-base =3D> 1) . $ENV{'SCR=
IPT_NAME'};
>                 }
>         }
>
> before it calls unescape(), I know $my_url is a
> http://localhost/gitweb.cgi and after it calls unescape, it becomes
> undefined.  That will trigger a "Use of uninitialized value $my_url
> in substitution (s///)" warning.
>
> unescape comes from CGI::Util because we do
>
>         use CGI::Util qw(unescape);
>
> early in the program.
>
> As a workaround I locally have the attached patch to disable calling
> CGI::Util::unescape implicitly as a sub, and instead make an
> explicit call to it as a class method, and it seems to make the
> tests pass.  Please do not ask me why it works---the reason why I am
> posting this message is to find somebody who can explain it to me ;-)

I also don't know why this fixes the issue, unfortunately.

>
> The "unescape" thing in CGI::Util.pm begins with the standard
> boilerplate that lets you call it as a plain-vanilla sub as well as
> a class method, like so:
>
>     # unescape URL-encoded data
>     sub unescape {
>       shift() if @_ > 0 and (ref($[0]) || (defined $[1] && $_[0] eq $CGI:=
:DefaultClass));
>
> but it seems that it has been that way since 2009, so it does not
> explain why it started breaking for me all of sudden, even though
> it _is_ curious that its counterpart in the same file, escape,
> starts slightly differently to (presumably) achieve the same thing.
>
>     sub escape {
>       # If we being called in an OO-context, discard the first argument.
>       shift() if @_ > 1 and ( ref($[0]) || (defined $[1] && $_[0] eq $CGI=
::DefaultClass));
>
> Notice that the former does "shift" as long as there is even a
> single argument, while the latter does so only when there are at
> least two arguments.  Both presumably would take a single argument,
> the string to either escape or unescape, and the shift is presumably
> to shift away the class object if they are called as class methods,
> so the guard at the beginning of unscape looks suspect, but I am not
> a Perl person, and as I said, it seems that the code has been that
> way since 2009, so it is very likely that I am barking up a wrong
> tree.
>
> Anyway.  TIA for whoever explains the solution to this puzzle to me.
>
>
>  gitweb/gitweb.perl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
> index ccd14e0e30..a0a8b79ef4 100755
> --- c/gitweb/gitweb.perl
> +++ w/gitweb/gitweb.perl
> @@ -13,7 +13,7 @@
>  # handle ACL in file access tests
>  use filetest 'access';
>  use CGI qw(:standard :escapeHTML -nosticky);
> -use CGI::Util qw(unescape);
> +use CGI::Util qw();
>  use CGI::Carp qw(fatalsToBrowser set_message);
>  use Encode;
>  use Fcntl ':mode';
> @@ -22,6 +22,11 @@
>  use Time::HiRes qw(gettimeofday tv_interval);
>  use Digest::MD5 qw(md5_hex);
>
> +sub unescape {
> +       my $url =3D shift;
> +       return CGI::Util->unescape($url);
> +}
> +
>  binmode STDOUT, ':utf8';
>
>  if (!defined($CGI::VERSION) || $CGI::VERSION < 4.08) {
>
