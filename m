From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 21:21:03 -0400
Message-ID: <76718490903111821u1323361m1e251564332c9b06@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <gp9jp7$uc3$1@ger.gmane.org>
	 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
	 <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:23:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZdQ-0006Iz-MU
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZCLBVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 21:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZCLBVH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 21:21:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:44151 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZCLBVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 21:21:05 -0400
Received: by rv-out-0506.google.com with SMTP id g37so274835rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 18:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8OlmYT1k5jqYqzvYXbBux+vla+DmCyfv41DvqnGfzjo=;
        b=YM2SoXfwE/s9/yUXfKG8TBRkNYtWAe4XfJeZla+Q1beIewnfqyW7N+bwpi9Sip3EWv
         wI/6GH9BYU2aVdi0OxkmqqbO2RTk8F995syBYWMMzJYEhxoCpyG/cR/DMkxi5FAXqitw
         1RvAFq4SZ0Iwd8MAPbyMRhN83NMNWyYbdpVjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uletynpVkQAOR+19hKYYoB6Z/sEaHtDV/UFe6xrtgTSOQAFiyPPdVZ71qzaJE45+XB
         bAS/kaxdYGUGGMh3m60jBq77z2OZmbo2t9ODSy2Bh0OjhXhZBfS8J3bvW5E01sWihIF3
         oKj3xYZH4GT6e48lVloWyWO8372azOhr65Dj8=
Received: by 10.141.69.12 with SMTP id w12mr4701590rvk.108.1236820863251; Wed, 
	11 Mar 2009 18:21:03 -0700 (PDT)
In-Reply-To: <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112997>

On Wed, Mar 11, 2009 at 9:14 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> - Local branches can be associated with remote tracking branches in
> the repo's config (.git/config). This association is done
> automatically in current git when creating a new local branch based o=
n
> a remote tracking branch (e.g, git checkout -b topic origin/master or
> git branch topic origin/master). (You can use --track and --no-track
> to be explicit about whether or not you want the association to
> happen.)
>
> The association itself is simply an entry in the repo's .git/config. =
e.g.:
>
> [branch "topic"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D origin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0merge =3D refs/heads/master

As Junio points out, a local branch can be associated with another
local branch, not just a remote-tracking branch. In the config, this
looks like:

[branch "topic"]
      remote =3D .
      merge =3D refs/heads/master

So now "topic" is associated with *local* branch master, not
remote-tracking branch master, and this is because "remote =3D ." means
"this repo right here".

But, when making a new branch based on a local branch via git branch
and git checkout, adding this association in the config is not the
default. You have to explicitly ask for it with --track.

Also, the default of whether or not to add the association can itself
be changed. See the entry for branch.autosetupmerge (and related
branch.autosetuprebase, which I didn't go into) in "git help config".

j.
