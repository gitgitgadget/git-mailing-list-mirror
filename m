From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 14:17:15 +0200
Message-ID: <4C1B63CB.7080209@viscovery.net>
References: <loom.20100618T122039-876@post.gmane.org> <1276859235-13534-1-git-send-email-edwintorok@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VMO2csO2ayBFZHdpbg==?= <edwintorok@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 14:17:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPaVj-0000ia-QC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 14:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761144Ab0FRMRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 08:17:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52863 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761111Ab0FRMRT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 08:17:19 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OPaVX-0007CW-Jp; Fri, 18 Jun 2010 14:17:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5B4B01660F;
	Fri, 18 Jun 2010 14:17:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1276859235-13534-1-git-send-email-edwintorok@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149342>

Am 6/18/2010 13:07, schrieb T=C3=B6r=C3=B6k Edwin:
>  		else if (S_ISDIR(st.st_mode)) {
> -			if (!remove_dir_recursively(path, only_empty))
> +			if (!remove_dir_recursively(path, only_empty)) {
> +				did_rm =3D 1;
>  				continue; /* happy */

Is it possible that remove_dir_recursively exits with 0, but it actuall=
y
did not remove the directory? That would result in an endless loop: it
would have to re-enter remove_dir_recursively on the next iteration,
return 0 again (without removing the directory), next iteration, etc.

-- Hannes
