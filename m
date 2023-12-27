Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88B46430
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xylogix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xylogix.net
Received: from oxusgagw00.schlund.de ([10.72.72.28]) by mrelay.perfora.net
 (mreueus002 [172.19.143.1]) with ESMTPSA (Nemesis) id
 0LgrQ0-1qw98E0DAM-00oD2l for <git@vger.kernel.org>; Wed, 27 Dec 2023 18:11:32
 +0100
Date: Wed, 27 Dec 2023 10:11:31 -0700 (MST)
From: Brian Hart <brian.hart@xylogix.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1858825158.1864122.1703697091856@mailbusiness.ionos.com>
Subject: Suppress 'info: please complete authentication in browser'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev56
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-Provags-ID: V03:K1:MG1IxEOOf+mcA9cOYSeuwwn79R077Kt0NewcSTSIvJlxZKAwZLA
 Et/iztAxYkGcOHFtyExwqv2RaoHMAwS+NJS1Tsl0JVrGcW5TvdVfvxnIB1C3gceM50X/0Cm
 HmG+8vPBZA5iFxSmO7Z2Gtw1Is4mV/bTuXbv5+pZWUBYGz7DM1vdrMrIPAGfGeRQ92+61W0
 U8hlwNTCwa/K8ccuJkZTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IdluLnWg7vM=;zFOp/sr4aIbAu5cTXhU3b1CvN+r
 6LFnKwWUnSATi0q6prsuLnYLSgw/QXWmY1G8ekzqh+MatcXUOEAwHngShzZeesXg4QTRjFfF9
 aBc1Jaw28W470ryVQp8SScMvBZnG5alpvwjuboI8vtl+IZQOZvd73B6WAgr72UrC+SwK66oJM
 L/57eIlrrJVlxImzSzf8HdifYAfJErXELy3sIhXx0FbN+SLnEGJeZ8ykU9tP6eVcUVpfG4dHh
 4egK3Xi1FY2NfcNKqkiVA33mT1fUeo7n1Ce2PvEui8tMe8TLLWktp+CDL8WcJuS4Gj5aWHzJ9
 ZZuDWY5tV39ofGrpfYW/WGVpgsBzCs3bWOf8ez7t8H1iCF4semtmLSWRtzz/NXNUf1Eemg6eI
 34EE93gk6oVzMbApcir8c+Wez7KFUyEgR+ZQ55VcWdrMofOZk0sW45sm5XWBwnVR85hWZby6K
 3AEg6wsFWCwrtYSVM19AXZ+jCB3k5jy614upxg1/RnSAM+1Y77pCEiLiXhJw/ddguydy6n/Td
 eErSMJR1d8r2Mu6PDp9bjtnymQXZiPyiOvKSBnELwO04WxlgYHRUHb8fGve4cupG9N5yyXUYp
 xksh/kjsblf13Xxeqld4Z0ZdJX+mnfhhL9JYyZToM0IyRMl3Bp7R+7ej4awwz5UfyjSjsnnnt
 2dxpd7XW8pGcFEjQUh1+WyU0keNxa3u5NxMOA0sK12sjxyyONrfrLgzq5yEyQcstbj95Bh9wV
 T4YgU6W0YoJXk7WfSw9Xl5qd3tagkqAdM3CaTMtyGdrChSKBuLZ2TDL+NGs+G/QyDpAhy3D9V
 K6iQc7ZFMPv+q3wVaw4Z0M2acaOPFeBAB3dlXVHXODGTKkEQCCf0m0YlWMCHIQq0AuO/efUfD
 O6qQ7jwExgogDdQ==

Git for Windows version: 2.43.0

Hello,

I am running a nightly shell script that syncs my local and remote Git repos. It kicks off at 7:30 PM each day. When I come into work the following morning, sporadically, I find that part of the script has not been executing for hours because a modal popup displays.

The text in the console is:
`info: please complete authentication in your browser`

At the same time, a modal pop-up appears. The modal popup needs a button clicked to open the browser and sign in. Upon doing so, the browser says "authentication successful," and the script continues -- but this is after I've woken up from being asleep, with the script otherwise sitting suspended all night long.

I've heard various suggestions before about using the Windows Credential Manager (I believe I am already) and such. It seems as if Git is programmed to ignore the Credential Manager periodically and demand the use of the browser to re-authenticate.

Here is the .sh script I am using, e.g., to do a pull on each directory in a root directory:

```
git config --global user.email "XXXXX" --replace-all; git config --global user.name "XXXXXX" --replace-all; git config --global credential.helper wincred --replace-all; for d in */; do cd $d; echo Processing repository in "${d%/}"...; git config credential.helper wincred; git remote update; git pull --all -v --no-rebase; git add --renormalize .; cd ..; done
```

As you can see I am using `git config --global credential.helper wincred --replace-all` and I am not sure why this should not work. NOTE: The 'XXXX' are for privacy.

How can I suppress the modal pop-up so I can run my overnight Git scripts?

Regards,


Brian Hart
