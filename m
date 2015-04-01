From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 08:53:30 -0400
Message-ID: <551BEA4A.9050708@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 14:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdIA6-0007lr-EI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 14:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbDAMyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 08:54:21 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33747 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbDAMyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 08:54:20 -0400
Received: by qgfa8 with SMTP id a8so41098420qgf.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zSZHjE+bZALv1V454aHVg22PSN5f3O3Q1C2LkrsT6HE=;
        b=RDaHgI63PwdTE7XDC1eMGTU08lmtraVQ5Ot5u6CK6Yu2Ags4yR4ZLBn9Wu+LjkCWws
         6fspbhhTHOx0R0ynOgGF7uXxs1br9OWvPEnw9H5kSY8meTt550tfLRnrTfmekhdsXlZF
         9tJ69aRpgGzCsatOaxnyyEahB2+oxxq9fbMJWkvSnB6EintCjcH9jWE4wRtx0NwuqrD8
         8N+ySQGu7LKjwZsi5zJNi3deXLrFzAJR8kyVDOuSdGclONou9IVijCDQEC+NXmh9UTy9
         cGxlxCzY1ACufyjgnUrERM44GSQZKYX/vAWChiOyWczjOYcN85A91hk1A+XrPFoshcs/
         9H2A==
X-Received: by 10.140.37.7 with SMTP id q7mr53056908qgq.29.1427892859951;
        Wed, 01 Apr 2015 05:54:19 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id 102sm1196202qkt.2.2015.04.01.05.54.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 05:54:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266603>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/1/2015 5:55 AM, Duy Nguyen wrote:
> On Wed, Apr 1, 2015 at 4:10 AM, Phillip Susi <psusi@ubuntu.com>
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> I made a shallow clone of my repo, then used git bundle create to
>> pack it all into a bundle file, then cloned from that bundle.
>> The initial shallow clone has a .git/shallow file that identifies
>> it as a shallow clone ( and I guess keeps things from complaining
>> about the missing history ), but the the repo cloned from the
>> bundle does not,
> 
> You made me worry a bit. We have checks in clone and fetch to make 
> sure the result is "good" (i.e. gitk should not complain,
> clone/fetch should report it instead). Unfortunately I tested and
> it seemed to work as expected (i.e. clone fails)
> 
> $ LANG=C ./git clone ./shallow.bundle  shallow2 Cloning into
> 'shallow2'... Receiving objects: 100% (2813/2813), 5.33 MiB | 0
> bytes/s, done. Resolving deltas: 100% (250/250), done. Checking
> connectivity... error: Could not read 
> 50a3ba22454e2989424d5de489de9c0f68fed5ec fatal: Failed to traverse
> parents of commit c73a8a63134734ddf7077d09355a10a0077ed2ca fatal:
> remote did not send all necessary objects

Strange; it works fine for me using git 1.9.4.msysgit.1, and then I
just get the complaints from gitk.  I created the bundle with no
prereq argument, i.e. "git bundle create shallow.bundle".  Did you use
a prereq argument?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVG+pKAAoJENRVrw2cjl5RLkMH/j0IlFsf5oEsFejLqD2fxFAJ
8r7pZCtYFvFqMqLQivLCdU/aYCd/5F99VUtusH3NphJvxkmCaLyRwLyA1KR/AozQ
slEXc5gmjbUg9yEBffYQ/xFPAGrizb2BblSzl6hcAZGtscLNyKvOjHttvJL+xM1+
uY0dwHcQ97m5p3DlehjLSAHolJF+waEhS6MarACZuSbi2JBTvo3OOagyt0o46sjp
t5v4kfRfTYD6DTlY+VPTUC56unBaVItLDfxY5d+iHGDY2o5rhl4AFWLbCh3v6ltl
OAuVs+UPKn0kV9tIQ6EBhQKf5CooCZtbr45OVGpVLPipjQFq2QqUjVWrLMEskhw=
=Fem/
-----END PGP SIGNATURE-----
