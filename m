From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] worktree: simplify prefixing paths
Date: Wed, 11 May 2016 07:46:13 +0700
Message-ID: <CACsJy8CiUBryRqbBHGYcMR7VSBtys3SD10T79_Dq9H6JQ=NiFw@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160510141553.22967-1-pclouds@gmail.com>
 <20160510141553.22967-7-pclouds@gmail.com> <xmqqvb2lldgg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 02:46:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IIb-0003C2-8X
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 02:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbcEKAqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 20:46:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33593 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbcEKAqo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 20:46:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8so3244912lfd.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e8ZeszBwBmLP7FXxIPrwQ6jT6LB+i6khgcMCTl8/PBk=;
        b=IT4nFh2/IhhsBlatIVMFMt0ZcCkOIA6EIsk9gATPx/FWCWS7nWZuKexTxRwzdVePbh
         HDDyXeSo0DFh3ip6VoUIW1+TfK8thu3LOtE3DbKVYC9KaJs+56G+dL6Pr988bgSDKPxz
         qUGRMKldVLrlIekN2+4itrP3HwULHL90GOpzwW648p2v56uiWpuj/8xc/2WQXEGA8BCE
         rH0fGzZ5ocHYr5jN91pduy3wsTOkfw2EGTTyrbb9ChaZTiKM95/ODDD2S46FSbGEGo/M
         L4Y3Bg6OlQIKSo8W3WKPf1BXOFRDnsSndrcY6fQWQqjOu8KLIT7rAKLVSvTJxWd64FNK
         OsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e8ZeszBwBmLP7FXxIPrwQ6jT6LB+i6khgcMCTl8/PBk=;
        b=l+o6B0b+9jDqAGdFWpv87Qba5Huwjr3RA6idrDbzoNaErURfZWZuhi+jlcDyr8wUWB
         VJ6/ws2UvENz2h5EIpTWQX2l9+FJR3HVMflgcYYvNNpHyUig15wT5w0zfNNhJrHhH2bs
         un0GlnBRsjLwombu1nDhNYkIwY1fm2TG4EstPbAVFxTFKA/2ZKPSnqDBbVPF0un7kAVr
         Li6D0CP2jn1m+lgCiM54BU0Ctn/26PlGzLIJQFuQPB+q+x2AsWpesDNnf1UPr0Fki9oh
         2wrhKJiuKewlc0nL0McS9rrfUtqvKtuBFx9fCB/CTb1v0Gb/kaxoWKOjcc+SAu17H7pX
         WbTA==
X-Gm-Message-State: AOPr4FUtD9wsYNvwJQ75bqiSW+tm7e+tstdg+GZNAQp9AnTZLI/XKoC0w7wLiORutvgMqzXD0sruz80mR38PAw==
X-Received: by 10.25.22.19 with SMTP id m19mr193826lfi.118.1462927603069; Tue,
 10 May 2016 17:46:43 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 17:46:13 -0700 (PDT)
In-Reply-To: <xmqqvb2lldgg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294208>

On Wed, May 11, 2016 at 6:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> This changes semantics, doesn't it?  prefix_filename() seems to do a
> lot more than just strbuf_vadd("%s%s", prefix, filename); would do.
>
> It may be a good change (e.g. turn '\' into '/' on Windows), but
> this is way more than "simplify prefixing".  It is something else
> whose effect needs to be explained.

On Wed, May 11, 2016 at 6:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> This changes semantics, doesn't it?  prefix_filename() seems to do a
> lot more than just strbuf_vadd("%s%s", prefix, filename); would do.
>
> It may be a good change (e.g. turn '\' into '/' on Windows), but
> this is way more than "simplify prefixing".  It is something else
> whose effect needs to be explained.

I admit I forgot about Windows part in prefix_filename(). For
non-Windows code, it's exactly the same behavior. Maybe we should do
this to emphasize that prefix_filename() is no-op when pfx_len is
zero? The same pattern is used elsewhere too (or I'm spreading it in
my local tree..) Unless of course if convert_slashes() is a good thing
to always do, then I need to update my commit message (+Johannes for
this question).

diff --git a/abspath.c b/abspath.c
index 2825de8..bf454e0 100644
--- a/abspath.c
+++ b/abspath.c
@@ -160,8 +160,11 @@ const char *absolute_path(const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *=
arg)
 {
  static struct strbuf path =3D STRBUF_INIT;
+
+ if (!pfx_len)
+ return arg;
 #ifndef GIT_WINDOWS_NATIVE
- if (!pfx_len || is_absolute_path(arg))
+ if (is_absolute_path(arg))
  return arg;
  strbuf_reset(&path);
  strbuf_add(&path, pfx, pfx_len);

>
>>  builtin/worktree.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index b53f802..f9dac37 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -337,7 +337,7 @@ static int add(int ac, const char **av, const ch=
ar *prefix)
>>       if (ac < 1 || ac > 2)
>>               usage_with_options(worktree_usage, options);
>>
>> -     path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0=
]) : av[0];
>> +     path =3D prefix_filename(prefix, strlen(prefix), av[0]);
>>       branch =3D ac < 2 ? "HEAD" : av[1];
>>
>>       opts.force_new_branch =3D !!new_branch_force;
>> @@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const =
char *prefix)
>>
>>       if (ac < 2)
>>               usage_with_options(worktree_usage, options);
>> +     if (!prefix)
>> +             prefix =3D "";
>>       if (!strcmp(av[1], "add"))
>>               return add(ac - 1, av + 1, prefix);
>>       if (!strcmp(av[1], "prune"))
--=20
Duy
