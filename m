From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always 
	cherry-picks a commit.
Date: Mon, 22 Mar 2010 16:23:19 -0400
Message-ID: <32541b131003221323u1ed540bbi87d8d427cfcc421a@mail.gmail.com>
References: <4BA11B23.4090801@xiplink.com> <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:23:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtoA5-00028p-P7
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab0CVUXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 16:23:41 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:37495 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0CVUXk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 16:23:40 -0400
Received: by gxk9 with SMTP id 9so694013gxk.8
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MVrwJv7lVxmfx85O7xQUorHmQP4MKGONoYc7BpPqOBo=;
        b=V5eyXO7o6Hi3kIZvRZcMZr2KhZ5oYLnsMGcEmfXAEv8P1lMYAFOVh/HUB43c/wo/z1
         08YoH2jjko1DSaqP0d3mkGMv8eBaoMZ7yGf8umGpuibiqPz9JWVvF/Eno8ucWYn0bXhB
         Huo0o6HYMXbBXtd3xu9aYqYfMA1m+Z72gct9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dQRpVFhTswaJ+7n/DvWjCZGHIDViV4wgLaOAKWSTaoz7/LZF+GWlBPPKYS30WULnee
         nYUzjwwEEgDT/r/C44KNsnU+StqmDWQ3TJtxfg5NqUdK7h0q6+mSkQ/FQsHgIB5XRaLb
         RccKvfEYfXJpp52sx6yrPWVB36b9KGaT1p5Vo=
Received: by 10.150.32.3 with SMTP id f3mr2120619ybf.163.1269289419178; Mon, 
	22 Mar 2010 13:23:39 -0700 (PDT)
In-Reply-To: <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142965>

On Mon, Mar 22, 2010 at 3:25 PM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
> +Sometimes you're in a situation like this
> +
> + P---o---o---M---x---x---W---x
> + =A0\ =A0 =A0 =A0 =A0 /
> + =A0 A---B---C
> +
> +where you:
> +
> + - Need to rewrite one of the commits on the A-B-C branch; and
> +
> + - Want the rewritten A-B-C branch to still start at commit P (perha=
ps P
> + =A0 is a branching-off point for yet another branch, and you want b=
e able to
> + =A0 merge A-B-C into both branches).
> +
> +The natural thing to do in this case is to checkout the A-B-C branch=
 and use
> +"rebase -i A" to change commit B. =A0However, this does not rewrite =
commit A,
> +and you end up with this:
> +
> + P---o---o---M---x---x---W---x
> + =A0\ =A0 =A0 =A0 =A0 /
> + =A0 A---B---C =A0 <-- old branch
> + =A0 \
> + =A0 =A0B'---C' =A0 =A0<-- rewritten branch
> +
> +To merge A-B'-C' into the mainline branch you would still have to fi=
rst revert
> +commit W in order to pick up the changes in A, but then it's likely =
that the
> +changes in B' will conflict with the original B changes re-introduce=
d by the
> +reversion of W.

I think you need to clarify in the above text that W is a revert of M.
 I was very confused by this at first.

Other than that, I'll leave it to others more opinionated than me to
comment on whether regenerating a commit just for the sake of
regenerating it is actually desirable or not :)

Have fun,

Avery
