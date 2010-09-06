From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 06:34:54 +0530
Message-ID: <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100905174105.GB14020@burratino>
	<20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
	<m3pqwrnay2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 03:05:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsQ8s-0004Ku-89
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 03:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab0IFBE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 21:04:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58544 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab0IFBE4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 21:04:56 -0400
Received: by gwj17 with SMTP id 17so1386882gwj.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FzhgP0YrRdIHkzy/q9NFEo8GGyvxBooA9sLTjYcWMOA=;
        b=PYh41JSzrg4sNxm/6obuMxsV4n0Tkt2IhCytGWLKtQf3FVOPVSAjvKbfluAUnXBOpJ
         7gfS7VbF31B7vh40m3Y2LtXEhzFbGYbAysIrlbw3aFlIFtUAkjsikDbPXAtjnDDwEl6C
         Kl2W0ZjsszJ4MwHiou8BJhrD05iFd52AZnNMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JM68kcFU/hmKHIRU7bexznds3f90Az6cnuJ/lSgFimlA25YmHvlxLmjeEYEnKJ3oMf
         wFV1om6eN874AkIPs/f7GfBEeMFQpo6oigtwEfwYFEZAfVN+nGOsl248tMj0ru2nW0VG
         wP+rGvpwIIaGc1tQZFUZ7Lf1Sh8f5M7KQ0vMg=
Received: by 10.90.99.16 with SMTP id w16mr1168066agb.69.1283735095013; Sun,
 05 Sep 2010 18:04:55 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Sun, 5 Sep 2010 18:04:54 -0700 (PDT)
In-Reply-To: <m3pqwrnay2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155512>

On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>> <ilari.liusvaara@elisanet.fi> wrote:
>>
>> > AFAIK, HTTP errors don't have descriptions printed.
>>
>> I don't know if this applies here but HTTP error codes can come with
>> any free-form \n-delimited string:
>>
>> =C2=A0 =C2=A0 HTTP/1.1 402 You Must Build Additional Pylons
>
> And you can also send more detailed description in the *body* (and no=
t
> only HTTP headers) of HTTP response, though I don't know if git does
> that.

I'm going to try the patch that Ilari sent when I get to work but to
answer this sub-thread about HTTP status codes and messages, none of
that gets printed by the curl code, as Ilari pointed out.  Here's a
transcript:

Notice the 403 on this one... I do send that back:

06:30:37 sitaram@sita-lt:http-test $ git clone `genurl alice foo/sitara=
m/try1`
Cloning into try1...
error: The requested URL returned error: 403 while accessing
http://alice:alice@127.0.0.1/git/foo/sitaram/try1/info/refs

fatal: HTTP request failed

You can see the actual message cleanly here:

06:30:46 sitaram@sita-lt:http-test $ curl
http://alice:alice@127.0.0.1/git/foo/sitaram/try1/info/refs
ERR R access for foo/sitaram/try1 DENIED to alice


And here you can see the text part of the HTTP/1.1 NNN status line:

06:31:04 sitaram@sita-lt:http-test $ curl -v
http://alice:alice@127.0.0.1/git/foo/sitaram/try1/info/refs
* About to connect() to 127.0.0.1 port 80 (#0)
*   Trying 127.0.0.1... connected
* Connected to 127.0.0.1 (127.0.0.1) port 80 (#0)
* Server auth using Basic with user 'alice'
> GET /git/foo/sitaram/try1/info/refs HTTP/1.1
> Authorization: Basic YWxpY2U6YWxpY2U=3D
> User-Agent: curl/7.20.1 (i386-redhat-linux-gnu) libcurl/7.20.1 NSS/3.=
12.6.2 zlib/1.2.3 libidn/1.16 libssh2/1.2.4
> Host: 127.0.0.1
> Accept: */*
>
< HTTP/1.1 403 error - gitolite
< Date: Mon, 06 Sep 2010 01:02:23 GMT
< Server: Apache/2.2.16 (Fedora)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=3D0, must-revalidate
< Connection: close
< Transfer-Encoding: chunked
< Content-Type: text/plain; charset=3DUTF-8
<
ERR R access for foo/sitaram/try1 DENIED to alice
* Closing connection #0
