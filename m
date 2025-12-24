Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC42E62A6
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595813; cv=none; b=PVTvKseHeapXTO2W0Q6xAEoAN1PFtPDnsyEZ2srQcTGy2qQHQaWSFWxdFXDgIgmK3PS6tsJPm/7ACMmleTvtxrXbhULAbZgeUaBJMtEyX4AL94EgF2iJnhYdb8UY5/BzhF3VKHNNL4TXlKEDMDGauhMDCAw1K51KMbPXIl6EZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595813; c=relaxed/simple;
	bh=xHJmeXP8QEYCi/2BVxqCKjW5/2TbC2JjNJNPRxqviyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhu6eNeiSB8IFtuPhh5zRYk8GKpAX4RCQnky1UpLBkbXyWr7u/AdwfehuNuEqe5sfhnVYkLQ6GrTR2p9KdGl4sX7ktEEoMqN3wrvIMqYm13Aeebzl2OvYWF7x1BDLf+vrLvlIiL1nd4olfzngNHNAy6XtsNjX+3+yFZwccABA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dYCmQj9Y; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dYCmQj9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595808; x=1767200608; i=l.s.r@web.de;
	bh=uHRfclTBYkE5wIcH/yT3esH1eO9seCK4AXTqoE1khyE=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dYCmQj9Y5TihW2dkR6ZE3C4qqgNE2l49oRB6cBtyh19UP7g10YbWAJzciV5N7ncA
	 0BU00AwP9Mr1nYSeVYkyegH89XqgD0ErvK5oYAuWlrx/ikR0IzrvHi5fCxCwTtFSH
	 cSaopf0vhnthza424x8UHK6a2sy3tp3O7+Tc9EqsgyeyfhNSTVhgPfPNulTkVpjaP
	 XEdHcW7FTIULncwuAKtreyjT2CSzRqoQYd+Ds+l/7UpTzwKMXdpSxGnggErDoeQGs
	 Utffbm9hyNNT8L02He0+KBqfscGxUsBlamhzLkwkEJ7MjFW0qotzY/dDwlRFNCPK3
	 XaHpx29IvLNNwE82dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MyNwm-1vrKTU1snk-00xmoh for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 00/14] export and use commit_stack
Date: Wed, 24 Dec 2025 18:03:13 +0100
Message-ID: <20251224170327.68049-1-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aq9zPQmXGGIKndN0iJ+E89obWS2fGeKDH/OZDX1w9Lsj4+yc+WD
 3I5fiz4rBwjUc0SuFuM8pX8sC2pjPv/rnY0Y7+y8SXaTBCe7wjX8Ti6i8NXbXkczpM/Qv4h
 UrU6Om799E2rISAzhxpyY1YTVHCtZMn2HwNhWbhGkM12TGf8HCKx97bKUr05pNrz164Mz4/
 p69ClD46Ci0oU9iHQtcXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vX/t5XzJE6M=;eliNJolqnTEqMzrMh0fDjujZu58
 lgqz/GhvOKGuyVm3lwh510hvhcLO4M38baNyxLE+9iIeZHfSnkOQ1RPnk/MVuso2lySSQSHcc
 9WF5hAsmfaasLfgT+R1VGDKsq7o0JAHkTklQ3U1hQNa1s53YkeeELGM2xB2tt4+zn6yzg7OaA
 i/7MAQWzHetuj1wbBsHRONpwEVdCVldk/NkZnPXMgeaKT04jjvzwEE2ZS1QVlp8Vm6oZBJSVW
 h5a6kjL1k6mkoW5T0EQiHL4xm9yXOg5jA/4kMbfHRDPPKMoAr5RVXYrib+x8mB2xqSW17oUq8
 PE2NS+7FKvgx1m+CuyPmSAjfYJs9OeTtIVpz2XgWL0dcfq8UJgLjbVvROb8XjzsOlc43Bj2g3
 Lnqgwjmy2e2sKzTLzGfYGKNHbkmiIIdHRTNbNHc+yI5Ry0F9qfps9S8iyf6xQYdKnUwRm5GsO
 nmx3svKboxfk+bg48mHM2Cxg8Bl4LPk4idMZKozJUDu+SFGYFq7Kbdg7qZV8o33yedXgQad4j
 qXrIHbyAU84ST6Tr64j0GvYsj/+MN0Rdg/ryA2BQV+5dnu1vsiaN+DJihw6kb4XuR69KCPb39
 uXBSb6wE7s6z8GJp9oxAGcQKWSLBpjZceA6e1I8LQOr/fBN9Nrum5TDXoFaNVUQ1KhgT1/HjC
 RC5ZMetOQU2GH56Lz58N7LG33TkCfKx5N/TipK4ynaCdZ8fE7/1vEfDpef6RvG5ukPgwv9hZK
 0jwbEXXXnJ/eW4au2Txw4piDjly3ueifO247sPGaiqg2i0/2OOPr6O6Mqf+A9owwV8j6Ikfwo
 T7TTlEIy9gUAFnbiMnAmeua2u6imldIEkeXkoDmHPGFDzjp6z+gIz+IsYMi2JP5a1sxec1xLi
 nOGDn4Fe1dM7ziu2HK29/HkelpN5C+sPN2ncBcoOOvRMLVO35wtpwFWrOmC1YJJHFUmc5ENZp
 emZBmkRemuMY/WnaCkimyp2vOWgY4+LncQKwyAxo3mpxnJkMSbZyk1knWC66tY0HUem8JzJnE
 W+XE4Zg7ibk82cQlLlraXuOzATL6JtDW/Iy0QvrQYFeszzKNQ/ua6eQgl0SKvm0w9VovrpAMn
 /GL6fqBas80jmZv5ypjKQJTw1bYtAkYXQ1EAvpZC6vvRKRt1e1eDNadQit1+CcY60RYK0582C
 8sAwxYWvfiLvg7ynQTwAVbTtTSB9sGRZYKsFWZc2xCifxNHRqTeRrg3P2ZAW42TE8CSAUipUY
 i6X0sAPJWQv1gBxkBafd4uhN4xATsgjQWpAhg5zekuczmwaPeN7SpMuJkGSSR1NQPy/RiISK0
 zpAhv0OIfuzfeeNaDqn0kOxvL7GMooDq2c0dAe/9FE9z+Dhj5lXmGSfLNkpFVYbB1pUc0XA9t
 bqG5REdVnD3ANqvyLvWUwTYMJv8CVCctUIMhmtlAow8TvIKtTMLH8MW8kzHs0tt7mcBGGN2Rh
 r9cabER2R2uPjjCncmxoR7LSztXe0PRlf4gjxdef6tClkcQWit/syo1H9+lvPi5pioKplRkhS
 cymJEvTwCiroDZE7ZPFsia2qlptRHHhUAhobMHwpSKYKPgof7yQlC+405CA572xfnm6/f08Ak
 7XrFwBXF67s0exVmmvhmSrFvj6zNH9JXSonN6ZNP/zsoPk5FSPWoONGuVflbLHLNWbYKyhY25
 CE1TAKzq9KrpY+CMGVFkR90wUXVpOiIB0as434uOWxloDBrXmtcNapW6tQRaNxTeO8slqTfz+
 F079AU64+/wVFcKPpQ9nSEqxZg6ia3NIu+NLMtg20ZDmyIOYhppVYfvwZ/ydA9fAqoSAaJcmk
 26wJmWEWrZP6LVq8+mXpIKyMdT2gR6VMco72oukuOOX7Ou0Jg3hX2fI4U8uf7sRqWt3Aj++Bn
 U6SlEAVlHkbMqYwPoAvU4mwU4ko8NK27/AQSmCh1lHseg1MkjaNSuFLlG9XYYKwvROvd5NS0q
 gz3IA0dzjwka1Qk+zG5sJ/I/Byc1xNTdMCq1JIcQGQXXo2EshibbLSoLMsaFvc1R1XbQRzUds
 Ckba+aEFgOqddYyLrzWtcUYmczS1wGCI5hNgpaPXAFemuNDAbHrXvIar6LbafQoFKXzXdhQKC
 2GaHZzgLeO97JmDuICrTNQmexj9qbt2z1FOyIJ02hCUg29VabmxzMFRMlL8HNykBw1I4z/cHt
 MuN74oMTHeWSwVJ3m+67U8L8Gkvq0WHVNja4N9pM25yU02Ttg3s6Tcaa3eowEu5UmpxhJ2kyI
 NID2tc6/TRwFMBbehmope4YxuOJNLAkVkVLeWPS/J+XlSowWW0BpBlFhAYVNjlUmHhNoMvapQ
 PXUi/3yrNOK6AM2iupOd5ykeqiMGY+Xsoh/WMEVQ3tUCSiUZWgka5xjpksjNkWGcO3AHth2B4
 7sKN0bd1D4b76rYpaWV2QiZS+HnagAtTWcWcWv0XoaO0wZHZNguTxiWJVoN+LWS+HqcmmXziU
 iv4invTONWePr2XINNM+3CgoMCBr7h3YMqSEyEmgjCw1go3KQ3L3//62bocXj2DijhmcjWT+e
 ++/0/aXR+L3pANQ3x07Tqr5KACiUtCOYTU2K4JB5E0j7a8eMG/4NrUDDxG9tGuguYN03v1JHJ
 XFg88Z4/ePFFM/fz0ygOKFyJWREKszv9hMrDM6UwGJb3i6P4Uuzcm2MIPm51JEinGnaBdWppM
 55CYgd9NciofqSCgoWq89UrGXSXiFIIHRW4ylF6BeGWeb03bn6AM9B8mnWOONWFO1h225IBNr
 SnOcc9o1RsHyT+fFc//FEbp83dP7rSrY1LIc0IYpJNmWItn60e5FcZP2k8T4PRJxOAth+w6Z6
 1J2aLxXHRKUZtB9HjETA3ArtIDgYU54j7Q4pw0p7B+JcCnr8AH/jK8mXkZOLNLFrgrFUz702Q
 AGztsrL1lW8gyTEv48Eutd2p7JDj9aOU1JAWnLs7066DgMNr0EMHJwxD2ghPFW1PR585wAXcy
 /NRaSDdAd0looE/FUFkBj6Dk2febgJCkjbwRCoOjh9hmraGvDjjQZEAiZWMEEWg30P/W1yvGW
 Dvd9lQmNGoIm7BBm+qz8pCln+sbc4bTnH0kwPlC/xc4N9k5TH+zwl9bltC2Y+5X4pMpUa8hzY
 VzcG1gG/u+jDBBtEYh6AjtW3J6EQ3e+yulgAzuTU+2gtZu09JdvSTf8O7UiPXGcso/2JK3l7v
 HM8dTzsYWS+NK5ND+NRGwRB9Ju13nLPfV/WlQXUy/tMkcqsALzaWk6Nju/d9xfdPxyRobHwI1
 RZnfa7v6NZH//Emic/dBOWMRFZee3ejyTyMctrsLOB0qUAZ50x7oUyo2YMSJSwOm/Q4A2Aao7
 QgY2p9DFD0DhCLAx2LsUF+BW2Azurk3QTHRXD0uuZE4nJ8YgEyZjRjS1df8dbXofVFKWMUBCm
 DjzneW+G9Hohmfo2neEpvm0hzaim01Ag0nIiXwdPinC8qpUx7D5Zy9S1dljLhB8IDKL26tlny
 st1kUK2R5kTG9+gcXcc968D8dMxnwFKiyYufw4/1eNPmbMl081W8+6tkFRtj6nc6WsZ6+upXL
 a71kGUN73okhlf9ad3i7TthjVR+tryg578tEotbzjT0KKseKqkngdsol4VtodOo/bHBEqO5po
 Y09bcI44d9GNjD75J93KTUyanLtDJkMK4C1RuNfBwNHNEk7ZApedIKtpaCQuj8uTM+kUrR1lM
 plNv13rD8fHjXa12NTfAd1Ts4GGOJHJWsgaqFsJI6gDnq6y9y1q3LP4PIwLJA2EEInZIbKw7i
 ATJOjMh8fVbXIASO053KnSGEWn03fdfDwPxP0BWu80gOQ61AvJuqkbztQpf8pAn5ARFRY52aC
 xZ3JNyhAKsb5R98Gcwv2bnd7A+7p1aVZ0SuY0yJGQnfYD7fHr1zNdaTwGJcMl3FNwBiyE7vAu
 zTt0yc5pFx9uY2E6V7VpFUjWacGVOVG5Fw8wzfkyhtmuztzlnV+4LtkT8jBNqnMT3qYGFgwia
 Ev3ofNZijF8fwlHDNruvt3ZLEI3NPRpRGYcpAy9lJXofoD2L1nhvQkKtwtGJ7le2nBGJWf/8O
 Rdh7eHwT6nELo4hjb5j9TL1yfQAsmc7Qt50fN5++XEfy4gIWn1eWUWTx/am14rMVcJKK1hz4r
 1jicjeypPaBQ+t43mqXO4SR0BdYkWTUIf+aFJZsMpci7008eFYTGIWFGtmIwCws2r1WydjJd5
 7Gv71BW5W7XbRrcwooCspUdOP0t9T4PjqD30/RnqK9fgg3y/HcENBs+1kMMbQctkqtF7bjIIK
 gKdAdDWHBa3zYM+WtgZWDv0prNufpy4pdeOot0Lhc4o9I8tKFJPfW8GI4W9R46GnZ+9y3P+UD
 WAkG2Sh7IV1fhrp8FCijY4IIR8eIvzXhHaHvc2Po5LPr79bIRCeGuT2zQK1BRkRhb1wjCe4t1
 eqtWqr6JPOdzVa5f0+5gwYlZLWtFP6ItwFXdBygZlz2ZGqCRazrfC7JsWrUCY8jESkYS/IaxG
 nSZXRd3Lhy8BI1GBQq97SSdCcvrhoAtGiF+/yw0+6XtrtLAxZsYsKqdvgMlL9NBDV52PVD6Q6
 nghA4I7Xlij3Qbt+SviBJPzatYcgPDFJ0GGigRfUh7d57p/3iAgWHLDvbf1O+SbXCgRW2K5e+
 oM8BGD+aNasTQDNyAi1H+xjOC99YWZzJgIRrmI8j+H88PhL/6Ub6OBiyW2SAmeibuefmAZ/3/
 Rdnw/7Ml3riXg3aZxEM8CeGYxeejY6JTibK2DiPE4jPyCoqT/sWVjtz8VVXx+Md5cjc8C2WV/
 jWS4FD30ocDiC+GUw4p6J0ydnrxS3x8gORLDolZJY/cEg5WVWJUVg3xkwiuGPkfX5r7gK9KsT
 F9MVjw+De/YyZ+RF7UCBfP1uNPrBc61hq21wzBRkB6vpkZJA5FBdrfgjF36RlqNRsK2gxJ41E
 DjTrLkRLAUcNV2rzH20Ru6JI4Jencsp/yKjIC1OeupZtFLNYvNXCE+twH35KfLbvcejtWOEQP
 i2HwEaDiXJKVUpUdpgwUrkKDBgclzBYVHGwSQwnyVK53YDFJ5h6COkYjqJtxllPE4g5alRRnx
 n3DEH8rDz7n67Ng8U/yVjx5Sh0=

There are more than ten different variants of dynamic arrays of commit
pointers.  Pick one implementation, export it, add _init() and _grow()
functions and use it to reduce code duplication.

  revision: export commit_stack
  log: use commit_stack
  midx: use commit_stack
  name-rev: use commit_stack
  remote: use commit_stack for local_commits
  remote: use commit_stack for sent_tips
  remote: use commit_stack for src_commits
  test-reach: use commit_stack

  commit: add commit_stack_init()
  pack-bitmap-write: use commit_stack
  shallow: use commit_stack

  commit: add commit_stack_grow()
  commit-graph: use commit_stack
  commit-reach: use commit_stack

 builtin/log.c         | 31 ++++++++--------
 builtin/name-rev.c    | 17 +++------
 commit-graph.c        | 86 ++++++++++++++++++++-----------------------
 commit-reach.c        | 25 ++++++-------
 commit.c              | 28 ++++++++++++++
 commit.h              | 12 ++++++
 midx-write.c          | 35 ++++++------------
 pack-bitmap-write.c   | 18 ++++-----
 remote.c              | 74 ++++++++++---------------------------
 revision.c            | 23 ------------
 shallow.c             | 44 +++++++++-------------
 shallow.h             |  4 +-
 t/helper/test-reach.c | 34 +++++++----------
 13 files changed, 184 insertions(+), 247 deletions(-)

=2D-=20
2.52.0

