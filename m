From: =?UTF-8?Q?Bartosz_G=C4=99za?= <bartoszgeza@gmail.com>
Subject: Re: Local cache for git objects
Date: Thu, 17 May 2012 22:36:37 +0200
Message-ID: <CALnNMuE=YQsXK-kiRUntNU_0s7s6ONgBk92dZN4UD0Va+qqF+Q@mail.gmail.com>
References: <CALnNMuHdNFktUkp+Vdc=ooTJ9ay_BJftAJ_toVaBDA5EOzt9ww@mail.gmail.com>
 <1337285744-ner-2739@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 22:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV7So-0008FU-7c
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab2EQUhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 16:37:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53900 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab2EQUhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 16:37:08 -0400
Received: by obbtb18 with SMTP id tb18so2958972obb.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SeLWh06K5M9RlHWJTts1EPVgknlnEoIU0hUIoD5i2h4=;
        b=KJtbziSUvU6OnmidUJxIAFcoSm+5q0ZLAchNHXFlbzpmjzO90uCTImTeXnHYREJQvk
         wFOwK42ToWIYTJzARWTpTRYgioEZedmY/QCdEjPFS5dOQr32bNa0aDEmcbSqi1A1mytU
         Ro2cV5p71HoCWFQ8d8lv1wsMgGxQriuBbpvI6zPTaUT1d2GbxYatsRVQI6SHrfS6yGTT
         gi+A+nbeLPVmMI3VlJwT4I7MQmfewHQuHzeoTQKdhaYCOFUe90cj5/obi6GhcPcJu8fr
         JfUOr4qHVLiVAJVZYy8Cu8N24Y3u7cIqS6LYXLzSiKWrz+wOSe6aQHUN/FUWZT0w0XVt
         /0Cw==
Received: by 10.182.172.100 with SMTP id bb4mr7780652obc.22.1337287027967;
 Thu, 17 May 2012 13:37:07 -0700 (PDT)
Received: by 10.76.74.35 with HTTP; Thu, 17 May 2012 13:36:37 -0700 (PDT)
In-Reply-To: <1337285744-ner-2739@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197928>

On Thu, May 17, 2012 at 10:15 PM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Thu, 17 May 2012 22:06:51 +0200, Bartosz G=C4=99za <bartoszgeza@gm=
ail.com> wrote:
>> I'd like to speed up fetching objects from remote repositiories when=
 creating
>> multiple clones on one or more machines in LAN.
> Does git clone --reference do what you want?

I didn't know about --reference, but that's not it.
I've tried it just now:

$ git init --bare reference.git
Initialized empty Git repository in /.../reference.git
$ git clone --reference ./reference.git/ git://someurl/foo.git foo
Cloning into 'foo'...
[...] (fetches whole pack)
$ git clone --reference ./reference.git/ git://someurl/foo.git foo2
Cloning into 'foo2'...
[...] (fetches whole pack again)

Reference is read only (?)
I'd like to set up one global cache repository and forget.
Later as I fetch any objects they are stored there for fast future acce=
ss.
