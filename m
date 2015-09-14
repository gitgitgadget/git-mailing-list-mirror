From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Mon, 14 Sep 2015 15:37:15 +0000
Message-ID: <1442245035.10125.18.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "pclouds@gmail.com" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 17:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbVor-00023l-Go
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 17:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbbINPhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 11:37:21 -0400
Received: from smtp.transmode.se ([31.15.61.139]:57031 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbbINPhU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 11:37:20 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 3A04E1186FB8;
	Mon, 14 Sep 2015 17:37:17 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Mon, 14 Sep
 2015 17:37:17 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Mon, 14 Sep 2015 17:37:17 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ3AWr4MUVkjVcJE+EJNOGRY0lNp4lzPKAgBZf8YA=
In-Reply-To: <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <26D430EF7D4C27458603DD95CFFDCF48@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277833>

On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
> On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > I cannot push:
> > # > git push origin
> > Login for jocke@git.transmode.se
> > Password:
> > Counting objects: 7, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (7/7), done.
> > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> > Total 7 (delta 4), reused 0 (delta 0)
> > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission
> > denied
> > fatal: The remote end hung up unexpectedly
> > fatal: The remote end hung up unexpectedly
> 
> Noted. Will try to fix (but probably not fast). At first I thought
> this was an old bug, but that old bug [1] is in the fetch/clone path,
> not push. Not sure if the same approach can be reused here (i.e.avoid
> temp files altoghether).
> 
> [1] b790e0f (upload-pack: send shallow info over stdin to pack-objects
> - 2014-03-11)

Noticed I had forgotten to reply ...

An even simpler fix would be to have an tmp dir within the repo, aka:
 /var/git/tmv3-target-overlay.git/tmp/shallow_Un8ZOR
This would cover all cases when one must create a tmp file

 Jocke