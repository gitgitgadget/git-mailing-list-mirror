From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Sun, 18 Jul 2010 22:49:41 +0800
Message-ID: <AANLkTimNAyKZNdIIc6R5ylHuOVJho7UF0fnYC8jiaF9i@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-5-git-send-email-struggleyb.nku@gmail.com>
	<7vbpab2de5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 16:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaVBc-0007BI-2G
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 16:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab0GROto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 10:49:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65470 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0GROtm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 10:49:42 -0400
Received: by qwh6 with SMTP id 6so1337630qwh.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yJ+0c5xUbGq10/8mbkeAGugq0oDutdrw0FYf3aO3Fzw=;
        b=EWghQtDBAPNeSrYTdGzmxQMhgfu9n7RiotazBY7B9mStLTW7E/ibz4ZEUFAmR1aREh
         fx9Zs6W1rfGuIE/lNSxcqXksgZT9dl6f0oh/91ilebsVOQG+Ot1gF++paAXJyUuEJJCA
         TM4JPgsdJ/DgG+0rWvTNC2xlJ2cdHaNOCt2iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z5hXNfBuq70ECD+5wealnaeK1G32gIJYyAWE2lQmM7F/0NMpD9rUKlse9HyFdTYJEm
         T1kc0p1Qo5uPZ7DpPYw6E023lIdGTxIrC9TCmcE12L+3rl0cHXQSv6OtK59CHndkyloH
         vx4FVQy5NJfb6btvKb4YoQJKAs2GlO2Lt4XHs=
Received: by 10.224.19.66 with SMTP id z2mr3159936qaa.187.1279464581361; Sun, 
	18 Jul 2010 07:49:41 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sun, 18 Jul 2010 07:49:41 -0700 (PDT)
In-Reply-To: <7vbpab2de5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151214>

Hi Junio,

On Wed, Jul 14, 2010 at 7:03 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =A0 =A0 =A0 if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage(builtin_log_usage);
>> +
>> + =A0 =A0 parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KE=
EP_DASHDASH |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARSE_OPT_KEEP_ARGV0 | PAR=
SE_OPT_STOP_AT_NON_OPTION);
>> + =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (parse_options_step(&ctx, options, =
log_opt_usage)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_HELP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(129);
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_DONE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto parse_done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PARSE_OPT_NON_OPTION:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path =3D parse_options_cur=
rent(&ctx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pathspec =3D prefix_path(p=
refix, prefix ? strlen(prefix) : 0, path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 range->spec =3D alloc_file=
spec(pathspec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free((void *)pathspec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (range->nr =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(range->=
next) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 die("Path %s need a -L <range> option\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "If you want follow the history of the whole file "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "whether to using 'git log' without -L or using "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "'git log -L 1,$ <path>'", range->spec->path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 parse_options_next(&ctx, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
>
> This loop smells bad.
>
> When "-L n,m" appears on the command line, log_line_range_callback() =
would
> be called and would eat n,m (which is correct), but at that point you
> would not just want to be prepared to accept a non-option ("path" in =
"-L
> n,m path"), but actually would want to force the user to give a path,=
 no?
> IOW, isn't "git log -L n,m -U20" an error, unless "-U20" is a filenam=
e
> that the user wants to track?
>
> I somehow suspect that futzing with STOP_AT_NON_OPTION (done in the f=
irst
> two patches in the series) to parse "-L n,m path" is a misguided desi=
gn
> attempt. =A0Shouldn't you be instead giving a support for option call=
back to
> take more than one argument to do this?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct diff_line_range *r =
=3D xmalloc(sizeof(*r));
>
> decl-after-statement, but at this point it may be moot as I am doubti=
ng
> the higher-level design of this option parser now.
>

The point is that, the syntax we support is:

-L n1,m1 -L n2,m2 pathspec1  -L n3,m3 pathspec2

There can be multiple -L options for one pathspec, so I think the
STOP_AT_NON_OPTION way is better.

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
