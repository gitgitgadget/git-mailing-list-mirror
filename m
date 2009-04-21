From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [RFC/PATCH] graph API: Use horizontal lines for more compact 
	graphs
Date: Mon, 20 Apr 2009 22:23:20 -0400
Message-ID: <b2e43f8f0904201923hd97f3e3v66addf59daa3956f@mail.gmail.com>
References: <20090421004027.GA12330@linux.vnet>
	 <alpine.DEB.1.00.0904210255280.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5fM-00054f-Mm
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbZDUCXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 22:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZDUCXW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:23:22 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:40467 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZDUCXV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 22:23:21 -0400
Received: by qyk16 with SMTP id 16so684043qyk.33
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 19:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nvMwuNge0q3GSQf2QYg+HHqEKTQ6jNYKnKOCxHvDZFU=;
        b=BxR4qWYEoVDz98NSrT3tJdNHyaHKV4ILgekAYul/OJUUYu9g37pRawUmv3NuCRT0Jn
         wip4scKaQkWqe0WmIxAscj6ogfGWE4RtLp3GmhCgn7HCQluaRlNG8ZjTrJzIpRcR6UmO
         RsWSeWcHLehUlOq8Sg0D64qo/MBW/JcvvEheA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fIqV6MId02sOxyW/nh9vWIDV08JwB0wyyYivDE1A4HU7bUrFr1oXgAkTJVNjqZsVq4
         5BWLIdaBk2gIH53gEa/r0SKdF4DzRoKM28yVd/IW6llfL5RyQMmqFj2/t/YUF2/CtDTf
         XUOVhJidkLbFTO3Gik2GFhP3wBj7LULTwoImw=
Received: by 10.220.45.205 with SMTP id g13mr7320165vcf.64.1240280600642; Mon, 
	20 Apr 2009 19:23:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904210255280.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117076>

On Mon, Apr 20, 2009 at 8:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 20 Apr 2009, Allan Caffee wrote:
>
>> diff --git a/graph.c b/graph.c
>> index d4571cf..597e545 100644
>> --- a/graph.c
>> +++ b/graph.c
>> @@ -47,20 +47,6 @@ static void graph_show_strbuf(struct git_graph *g=
raph, struct strbuf const *sb);
>> =A0 * - Limit the number of columns, similar to the way gitk does.
>> =A0 * =A0 If we reach more than a specified number of columns, omit
>> =A0 * =A0 sections of some columns.
>> - *
>> - * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING st=
ates
>> - * =A0 could be made more compact by printing horizontal lines, ins=
tead of
>> - * =A0 long diagonal lines. =A0For example, during collapsing, some=
thing like
>> - * =A0 this: =A0 =A0 =A0 =A0 =A0instead of this:
>> - * =A0 | | | | | =A0 =A0 =A0| | | | |
>> - * =A0 | |_|_|/ =A0 =A0 =A0 | | | |/
>> - * =A0 |/| | | =A0 =A0 =A0 =A0| | |/|
>> - * =A0 | | | | =A0 =A0 =A0 =A0| |/| |
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|/| | |
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| | | |
>> - *
>> - * =A0 If there are several parallel diagonal lines, they will need=
 to be
>> - * =A0 replaced with horizontal lines on subsequent rows.
>
> I like it!

:) Good!

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D=
 (target * 2)+3; j < (i - 2); j +=3D 2)
>
> This (target*2)+3 is a bit too magical for me to understand. =A0But m=
aybe I
> am just too tired?

It is a little magical.  Here target is an index into
graph->new_columns so we double that to get the actual location of the
edge in the string for this line.  So if we take the example that was
in the original TODO:

t(c)
|  t(c) + 3 (i.e. the first horizontal edge)
|  |
v..v    c
| | | | |
| |_|_|/
|/| | |
| | | |

Where c is the "horizontal_edge", t(c) is the target of the
"horizontal_edge" and t(c) + 3 is the location of the first horizontal
segment.  And then of course the +=3D 2 is because we don't want to
change the mappings of the existing vertical edges.  This could really
probably use a comment (suggestions welcome).

Hope that clears things up,
~Allan
