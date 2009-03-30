From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [POC PATCH] diff options: Introduce --interactive
Date: Mon, 30 Mar 2009 17:38:52 +0800
Message-ID: <46dff0320903300238s425c4c35nc501b403b0bc3c87@mail.gmail.com>
References: <1238391670-4421-1-git-send-email-pkufranky@gmail.com>
	 <20090330090438.GA18953@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDyk-0004WZ-Nh
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbZC3Ji4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 05:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZC3Jiz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:38:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:48986 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbZC3Jiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:38:54 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1278133wah.21
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fBa1CjGmgkvqngqCeh2R2gywyUAWVm0WjbwOJlZDkto=;
        b=u2+RBda+ZJtfy0fnTzcdg7T+yo9LFsdqdIiUUb03vMKx4HBxfsgEU3seDNRNqSXgsE
         e4uQcLivanZO3Tj9cwOoNPXf4ZxYGJU60MTWl5/1DSxXIS2Dv9eqknGCY/85Hu6Ssvz4
         VeokSelK4XDFHu62HfGVdhoE4x6oFQT966QMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SkCxnFWGB+n2jGuymEjhTWEfCdmtqBrstj1pPauIJjbjWR4moIcZ+F+AAdYlbrFtwe
         8Lr9FfxJBVIjj9JuE3kbWtJv9NP69N6HDTE+g+qSK/xr3v9V2dGrhwFqp9eGZwEQt2M+
         zRiY1ybt2jj5fdtgB32xm2N/irVjQv6j0Mlws=
Received: by 10.114.180.1 with SMTP id c1mr3441198waf.192.1238405932442; Mon, 
	30 Mar 2009 02:38:52 -0700 (PDT)
In-Reply-To: <20090330090438.GA18953@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115120>

On Mon, Mar 30, 2009 at 5:04 PM, David Aguilar <davvid@gmail.com> wrote=
:
> On =C2=A00, Ping Yin <pkufranky@gmail.com> wrote:
>> The new option --interactive introduces an interactive diff mode. No=
w we
>> can choose to see the diff for a selected file.
>
> I just tried it out. =C2=A0Very cool.
> It's exactly the functionality users have asked me about.
>
> I just sent a for-the-future patch that teaches difftool
> to tell difftool-helper that it shouldn't prompt when
> you're using --interactive.
>
> I noticed git-diff doesn't have a -i flag yet,
> perhaps it could be the shorthand for --interactive?
>
> (I'd have to change that for-the-future patch I just sent
> =C2=A0too since it also only checks for the long form...)
>
> I like it.
>
>>
>> This is a preparation to introduce the --tool option to launch the
>> external diff tool for a selected file.
>
> With both of our latest patches:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git difftool --interactive <revargs>
>
> does exactly what one would expect it to.
>
>
> How are you envisioning --tool? =C2=A0It'd be great if we didn't
> need the perl wrapper, though something does need to set
> GIT_EXTERNAL_DIFF/GIT_PAGER/etc... (that is, unless you have a
> better way =3D))

These environment vars can be set in diff.c directly, by passing the
git-difftool. So i think the difftool wrapper can be just removed once
the --tool option is available

>
>
>> >> When the user types a number, =C2=A0git-difftool-helper is launch=
ed to show
>> >> the diff for the corresponding file.
>> >
>> > Cool.
>> > I had two patches that I sent to the list for
>> > git-difftool.perl. =C2=A0If you're going to patch it then you migh=
t
>> > want to base it on top of those.
>> >
>> When i try to code on git-difftool.perl, i find it is more appropria=
te to add
>> the --interactive and then --tool options to git-diff itself. So her=
e is a
>> proof of concept patch based on next. What we should do next is to t=
ry to
>> design a good UI.
>
> I'll see if I can come up with any suggestions.
> I liked it on the first test drive.
>

Here is the UI i am envisioning, although i am not a good ui designer

1. interactive diff

$ git diff --interactive
1: M -10/+20   a.c
2: R -5 /+0    a1.c =3D> a2.c
3: C -5 /+0    b1.c =3D> b2.c

[p] What now [<n>,t<n>?,p<n>,t,p,q,?]?

When hitting '?'
<n>  - see diff of file <n> in default mode
p<n> - see diff of file <n> in patch mode
t<n> - see diff of file <n> in tool mode
p    - change to patch diff mode
t    - change to tool diff mode
q    - quit this ineraction
?    - print help

When hitting 't'
[t] What now [<n>,t<n>?,p<n>,t,p,q,?]?

2. interactive diff with --tool
if using "git diff --interactive --tool", then the default diff mode is=
 tool

$ git diff --interactive --tool
1: M -10/+20   a.c
2: R -5 /+0    a1.c =3D> a2.c
3: C -5 /+0    b1.c =3D> b2.c

[t] What now [<n>,t<n>?,p<n>,t,p,q,?]?

3. other considerations
 - --tool can imply --interactive
 - --interactive can imply -p
 - pager is disabled in interactive mode
