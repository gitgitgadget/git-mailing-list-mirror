From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC] git submodule purge
Date: Mon, 16 Mar 2015 14:44:07 +0100
Message-ID: <20150316134407.GA31794@pks-tp.elego.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 14:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXVJT-0007Sp-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 14:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbCPNoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 09:44:07 -0400
Received: from sender1.zohomail.com ([74.201.84.155]:29032 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbbCPNoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 09:44:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:subject:message-id:mime-version:content-type; 
  b=0ZHUu/q2p9cRwpa/wg30oLsBwXlqN8LHXlBEJ7dP7YNOlOnbRIWfo69IwcccChFcZP6b9ZqdbRFw
    kIX+qysDxdsqzRhlrhJW9nVGJHV5b+O3kwbploLJFXFDzi3SzT8K0RD2W74duivZ6orSuDpj/jfr
    cp9zMPdY1SAE9QFbdAA=  
Received: from localhost (46.189.27.162 [46.189.27.162]) by mx.zohomail.com
	with SMTPS id 1426513440258375.6802739753408; Mon, 16 Mar 2015 06:44:00 -0700 (PDT)
Content-Disposition: inline
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265557>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This proposal is just for discussion. If there is any interest I
will implement the feature and send some patches.


Currently it is hard to properly remove submodules. That is when
a submodule is deinitialized and removed from a repository the
directory '.git/modules/<SM_NAME>' will still be present and
there is no way to remove it despite manually calling `rm` on it.
I think there should be a command that is able to remove those
dangling repositories if the following conditions are met:

- the submodule should not be initialized

- the submodule should not have an entry in .gitmodules in the
  currently checked out revision

- the submodule should not contain any commits that are not
  upstream

- the submodule should not contain other submodules that do not
  meet those conditions

This would ensure that it is hard to loose any commits that may
be of interest. In the case that the user knows what he is doing
we may provide a '--force' switch to override those checks.

What is problematic, though, is when there are multiple branches
under active development where one branch contains a submodule
and another one does not. Given the checks listed above, though,
an accidentally removed submodule repository should not prove
problematic as it should be possible to easily re-clone it. It
might just be cumbersome if the user accidentally removes a
submodule and has to re-initialize it after switching branches.

Regarding behavior of the command I thought about something like
`git submodule purge (<SM_NAME>|<DIRECTORY>|-a)` where 'SM_NAME'
would remove the given submodule, 'DIRECTORY' would remove all
submodules under a certain directory and '-a' would remove all
submodules that are currently inactive. It might be useful to
provide a '--dry-run' switch that lists all submodules that would
be removed without actually removing them.

Some questions that arise here:

- should those actions be recursive? E.g. if a submodule contains
  submodules itself, should those be deleted (after the
  conditions are met), as well?

- should the user be asked for consent for every submodule that
  is about to be deleted or do we assume that he knows what he is
  doing?


Some feedback on this would be appreciated.

Regards
Patrick

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVBt4nAAoJEBF8Z7aeq/EsvUMP/iwrXRkyFw+IVIwRH6RUvwwp
sB8tfzn+bxhGjnQ8MYuu08Ovcd1ZyqKxK/nLwNXe8JfS6qmGdoVvPayIH4UnIhdU
3tWCjRl06ONS5KEwiLj882d41RbhrFWeEvqpgxlJOpABkDevm7bvOgO74in51N5w
f/i+JJCWf+atzulQNDM91f8btn0NpPuvczged13htHDwv0/+fTOdaxAOcOggv+bO
z7oUN2Km7YLE0Ca4uO9UIBtyThiqVCZSvkzKcB2St+zC9ty0stPwTLP6tV07Mgov
ezqrCF/63P0YBIzwlrFtfyw9tMEhz02sirTv/V7QhM63j4ALODAVThlgiAUiJIyI
gInNWC5xxJcVG4KUdzjLeOv3b6vWlCAcVRM+xEg0a3Y7cW2YGEW1UIDJ7Gu9oxhT
bDvMW88u2hoPQO5Xe5ssWEbxA/ymGRafBoiF4j3G/Z+n8bbpp5SyIdkPIHVn5eZC
Xx6tvir0RIVrqtjIEu+tGEOvczMraEqaN1H7nnAkpPx+l8Mgt3m6UXjTWRdbU3Dl
x15MtMiCK/LUx04Jdg4qkmRsjgyfS+dS5NqANQZ4EQsX2HOcit0rE7dDtP1t049k
EECJBvQJg+XuOTcvePrsnQ2WBAATubrcAXuRo2SlUaHJwM4vWHUrBbcUovXnbVsc
Vfs/uNcO2ku+DFam1mqF
=PqbO
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
