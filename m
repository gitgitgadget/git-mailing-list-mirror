From: =?ISO-8859-1?Q?David_Mart=EDnez_Mart=ED?= <desarrollo@gestiweb.com>
Subject: Possible bug in Git
Date: Thu, 15 Apr 2010 12:47:42 +0200
Message-ID: <4BC6EECE.6060408@gestiweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: deavidsedice@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 12:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2MiS-0000SD-GG
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 12:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab0DOKy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 06:54:27 -0400
Received: from h0016.hostytec.com ([86.109.162.148]:59318 "EHLO
	H0016.hostytec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab0DOKy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 06:54:26 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2010 06:54:26 EDT
Received: (qmail 3694 invoked by uid 112); 15 Apr 2010 12:47:37 +0200
Received: from 80.36.161.34 by H0016.hostytec.com (envelope-from <desarrollo@gestiweb.com>, uid 2020) with qmail-scanner-2.01st 
 (clamdscan: 0.88.7/8056. perlscan: 2.01st.  
 Clear:RC:0(80.36.161.34):. 
 Processed in 0.019294 secs); 15 Apr 2010 10:47:37 -0000
Received: from 34.red-80-36-161.staticip.rima-tde.net (HELO ?192.168.3.101?) (80.36.161.34)
  by h0016.hostytec.com with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Apr 2010 12:47:36 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144970>

(Please add deavidsedice@gmail.com and desarrollo@gestiweb.com to CC 
because I'm not suscripted to this list)

Here I've a strange behaviour in GIT:

We noticed a file in our repo is empty: 
facturacion/facturacion/scripts/lineasfacturascli.qs

We didn't found the reason using gitk --all -- 
facturacion/facturacion/scripts/lineasfacturascli.qs

With git bisect we found the problematic commit: 
dac6a95f559604978ff9e1fac24ad752c54382ae

With git show, it doesn't show anything about the modification:

$ git show dac6a95f5 -p --pretty=raw -- 
facturacion/facturacion/scripts/lineasfacturascli.qs
commit dac6a95f559604978ff9e1fac24ad752c54382ae
tree f1472f1d289f9813df5fd691c9cea6ccb04313a7
parent 5dfdd78f24f4578cdfeed876b8bacb45790af9ef
parent 6ed54c8c6508b6d5551290b45785eaf44dd05d75
author David Martinez Marti <desarrollo@gestiweb.com> 1260959309 +0100
committer David Martinez Marti <desarrollo@gestiweb.com> 1260959309 +0100

     Merge remote branch 'origin/infosial'

     Conflicts:
         contabilidad/informes/scripts/flcontinfo.qs
         facturacion/almacen/forms/articulos.ui
         facturacion/almacen/scripts/articulos.qs
         facturacion/almacen/tables/factalma_general.mtd
         facturacion/facturacion/forms/albaranescli.ui
         facturacion/facturacion/forms/albaranesprov.ui
         facturacion/facturacion/forms/facturasprov.ui
         facturacion/facturacion/forms/pedidoscli.ui
         facturacion/facturacion/forms/pedidosprov.ui
         facturacion/facturacion/forms/presupuestoscli.ui
         facturacion/facturacion/scripts/facturascli.qs
         facturacion/facturacion/scripts/facturasprov.qs
         facturacion/facturacion/scripts/flfacturac.qs
         facturacion/facturacion/scripts/lineasalbaranescli.qs
         facturacion/facturacion/scripts/lineasfacturascli.qs
         facturacion/facturacion/scripts/lineaspresupuestoscli.qs
         facturacion/informes/flfactinfo.xml
         facturacion/informes/forms/i_reciboscli.ui
         facturacion/informes/forms/i_recibosprov.ui
         facturacion/informes/queries/i_reciboscli.qry
         facturacion/informes/queries/i_recibosprov.qry
         facturacion/informes/queries/i_resreciboscli.qry
         facturacion/informes/queries/i_resrecibosprov.qry
         facturacion/informes/scripts/flfactinfo.qs
         facturacion/informes/scripts/i_masterinventario.qs
         facturacion/principal/flfactppal.xml
         facturacion/principal/forms/agentes.ui
         facturacion/principal/forms/clientes.ui
         facturacion/principal/forms/empresa.ui
         facturacion/principal/forms/flfactppal.ui
         facturacion/principal/forms/proveedores.ui
         facturacion/principal/scripts/clientes.qs
         facturacion/principal/scripts/proveedores.qs
         facturacion/principal/tables/clientes.mtd
         facturacion/principal/tables/proveedores.mtd
         facturacion/tesoreria/tables/reciboscli.mtd




There was a conflict on that file but it doesn't show anything changed 
about it. Gitk does the same.

git show commit^1:path and git show commit^2:path shows the files:

$ git show 
dac6a95f5^1:facturacion/facturacion/scripts/lineasfacturascli.qs | head
/***************************************************************************
                  lineasfacturascli.qs  -  description
                              -------------------
     begin                : lun abr 26 2004
     copyright            : (C) 2004 by InfoSiAL S.L.
     email                : mail@infosial.com
  ***************************************************************************/
/***************************************************************************
  *                                                                         *
  *   This program is free software; you can redistribute it and/or 
modify  *


$ git show 
dac6a95f5^2:facturacion/facturacion/scripts/lineasfacturascli.qs | head
/***************************************************************************
                  lineasfacturascli.qs  -  description
                              -------------------
     begin                : lun abr 26 2004
     copyright            : (C) 2004 by InfoSiAL S.L.
     email                : mail@infosial.com
  ***************************************************************************/
/***************************************************************************
  *                                                                         *
  *   This program is free software; you can redistribute it and/or 
modify  *


git show commit:path shows empty file:
$ git show 
dac6a95f5:facturacion/facturacion/scripts/lineasfacturascli.qs | wc
       0       0       0



I believe that changes *should* appear on git log -p and on gitk, and 
they doesn't, so I think it may be a bug in some git tools.

Tell me if I can do anything to fdetermine if it's really a bug and 
where it is to help GIT devs resovling it.

PD: I know my merge failed somehow, and I corrected it in a newer commit.
