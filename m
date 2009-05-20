From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v2] tg-graph: print dependency graph like git log 
	--graph
Date: Wed, 20 May 2009 12:48:53 +0200
Message-ID: <36ca99e90905200348i45e3ad0kf8efc655789702c0@mail.gmail.com>
References: <1242801900-30895-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090520103703.GS8212@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Wed May 20 12:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6jMN-0003Mo-Kq
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 12:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbZETKs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 06:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbZETKs4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 06:48:56 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64757 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbZETKsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 06:48:53 -0400
Received: by fxm2 with SMTP id 2so331557fxm.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PjNKPg2P4FkQTRtN2aFL5dcK6p7wHObw+qfbycYAepg=;
        b=DOhk6l3Ek4VdV77sYVVr3n4WptxvOm/SOfrxP1DwEjGL3HYdmyWfE6X+tX0Mz3MY5b
         qu3AltwHUt05poox23CkuPNKlylZ8xSyw2A8SAHnqt8rN+QE9oAhba92sfWudi6kjPe8
         rXJyZIL3HJ8s56OVlPhCgEzE48augewx2QQWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WagZ2IjSZm2FssGi/8o08hdt24aIn+pFyX/+JOvQzyAaZFVOUXFVKnjXpnYTPwdX8w
         xCNk/WrtHtp2lrItNCCj0w+QAsBhLUx4pnySsX+A1pIfjLZv4inPkEKe7dOvB1ggr0Bd
         YmfLyxsSZmg5N+dx30hMeyi03U5JgrOt09WOk=
Received: by 10.204.119.71 with SMTP id y7mr1130072bkq.16.1242816533690; Wed, 
	20 May 2009 03:48:53 -0700 (PDT)
In-Reply-To: <20090520103703.GS8212@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119600>

On Wed, May 20, 2009 at 12:37, Michael Radziej <mir@noris.de> wrote:
> On Wed, May 20, Bert Wesarg wrote:
>
>> ChangeLog:
>> =C2=A0v2:
>> =C2=A0 =C2=A0* fix rename bug which caused random segfaults in gvpr
>> =C2=A0 =C2=A0* add --decorate option, to print horizontal line from =
graph node to patch
>> =C2=A0 =C2=A0 =C2=A0name (like gitk do it for commits with tags or b=
ranch decorations)
>> =C2=A0 =C2=A0* in dfs mode we should maintain the order given by the=
 input
>> =C2=A0 =C2=A0* make dfs mode the default
>
> Hmm, still doesn't work, but in a different way ;-)
>
> a) graphviz 2.16-3ubuntu2
>
> mir@mir:topgit (bw/tg-graph-v2)> tg graph
> gvpr: "/usr/local/share/topgit/graph.gvpr", line 952: gg_nl_ret +=3D
> graph_output_commit_line();<<<
> =C2=A0-- cannot convert node_t to string
Just a note: I have never seen this error on my side.

> mir@mir:topgit (bw/tg-graph-v2)> tg summary --graphviz
> # GraphViz output; pipe to:
> # =C2=A0 | dot -Tpng -o <ouput>
> # or
> # =C2=A0 | dot -Txlib
>
> digraph G {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0graph [
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rankdir =3D "T=
B"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0label=3D"TopGi=
t Layout\n\n\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fontsize =3D 1=
4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0labelloc=3Dtop
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pad =3D "0.5,0=
=2E5"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0];
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"30154name" -> "master";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"30154name" -> "master";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"30154name" -> "master";
> }
Yeah, sorry I hand edited the patch to use printf instead of echo -e.

can you edit this line in tg-summary.sh:

printf "\t\"%s\" -> \"%s\";\n" "$$name" "$dep"

and change it to this (i.e. remove one '$' from '$$name'):

printf "\t\"%s\" -> \"%s\";\n" "$name" "$dep"

Bert

>
> Michael
