From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 12:01:35 +0800
Message-ID: <be6fef0d1001202001h4c794166y4bcf01b42f3ea1bb@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
	 <be6fef0d1001201736g9160306g51949a5f36d83e14@mail.gmail.com>
	 <20100121023310.GB18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXoEm-0007sv-Lt
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 05:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0AUEBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 23:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280Ab0AUEBh
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 23:01:37 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:48052 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0AUEBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 23:01:36 -0500
Received: by iwn34 with SMTP id 34so4312809iwn.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 20:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DLDazyF2yvsQPJmBRDxVbecTsVYfGivd/tQfdb4YpeM=;
        b=mzuTyhn4HL5ahyMa8CHXZgPUPZkXVea+ZvdqeTzpUpN6tTp4UBLcmCMKnQvLkfAjRK
         EPchLeU+r74rSNm5xO3/CINjEnh4zZiF/7Naj/AvvVcujTltIxSuzfjmRruClQ7xZhpI
         f1mcaQ3vQj8XDgPFwqGs0vw6eF/4Ph9uMQS5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sAL18f7prfxwW+QE99MzhsZfU/HJN1NRdye9M7aqdbI9hxcFHJAz+9bhu5jhodxmiN
         2oK0xqQy0snik1do/ahpaClMxHqoe00v/2hudC+EtUYSB652amVTU5rN4VFMpSggvwlc
         iRusKkVTpSH5pm2Ie9/V38cVvKHuj2luDf4D8=
Received: by 10.231.153.69 with SMTP id j5mr1491837ibw.33.1264046495565; Wed, 
	20 Jan 2010 20:01:35 -0800 (PST)
In-Reply-To: <20100121023310.GB18213@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137625>

Hi,

On Thu, Jan 21, 2010 at 10:33 AM, Yaroslav Halchenko
<debian@onerussian.com> wrote:
> * =A0 Trying 217.196.43.134... * Connected to git.debian.org (217.196=
=2E43.134) port 80 (#0)
>> GET /git/pkg-exppsy/pymvpa.git/info/refs?service=3Dgit-upload-pack H=
TTP/1.1
> User-Agent: git/1.6.6.267.g5b159
> Host: git.debian.org
> Accept: */*
> Pragma: no-cache
>
> * The requested URL returned error: 404
> * Closing connection #0
> fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?serv=
ice=3Dgit-upload-pack not found: did you run git update-server-info on =
the server?

I don't think git's at fault here, as we're getting a 404 Not Found.
Could you check that the repository (the one the url points to, after
taking into any url rewriting) is a bare one, ie. has structure

  pkg-exppsy/
  |-pymvpa.git
    |-objects/
    |-info/
    |-refs/
    |-...

rather than the non-bare

  pkg-exppsy/
  |-pymvpa.git
    |-.git
      |-objects/
      |-info/
      |-refs/
      |-...

?

> as for smart vs DAV -- don't see any smart alias handling in apache
> configuration (I have/had no clue about some smart http in git, just =
looked at
> apache template and saw smart aliases -- is there smth else to check =
within
> webserver config?)

If that's the case, I don't think it's related to your problem. (Btw,
"smart" refers to the http protocol that git can use to sync your
repo, via a CGI program on the server, instead of WebDAV. See
git-http-backend(1) for details.)

--=20
Cheers,
Ray Chuan
