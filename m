From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Mon, 26 Oct 2009 19:49:25 -0700
Message-ID: <4AE65FB5.3000905@gmail.com>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com> <7vocntd7vt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 03:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2c7r-0008NW-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 03:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbZJ0CtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 22:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZJ0CtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 22:49:25 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41965 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbZJ0CtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 22:49:24 -0400
Received: by yxe17 with SMTP id 17so10414926yxe.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Wtemr13t2AKilGyuDnT6MgK2VPQJ8Dn9MYvNT1hPFW4=;
        b=o0dTDZx3gHVlizaj9usXYFYD1yr+3zPy2dSoyIC0l8U54sn6LuNWUhGwfe6BPqUp/n
         eFrH30N7kGZXmQTGDfFMz2k6xJsVWvrkBCmdhANcyibtpacks4Bn1LUBSdgW+anWubJH
         ssdlFFJ4si/BeEZFD9p8zw+DYsr4M7kOs4x9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=NaMUcoxAR207z3meNk11/XkOb6Y+SdRBgiEJ1pV/1BQqiKkseETxOTECIwuoqyRaAe
         iSuP9CzBYz0ntFbHJylfN6qj5Cb0JlPNJPBT+bkke/cR7PAgPB4mG8nVVspyk6JhE8ZK
         djaPKrRv8/w7BLOg/oNt32rQBsMb2HLvGz/Bo=
Received: by 10.151.1.3 with SMTP id d3mr25434937ybi.305.1256611768865;
        Mon, 26 Oct 2009 19:49:28 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 15sm280440gxk.0.2009.10.26.19.49.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 19:49:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <7vocntd7vt.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131305>

Junio C Hamano wrote:
>
> If we are going to do this, wouldn't it make more sense to revert the
> rename of the script, so that people can keep relying on the name of the
> script being "git-completion.bash", _but_ make it produce a pre-compiled
> form to a separate file when invoked in some particular way?

Wouldn't relying on "git-completion.bash" to produce the pre-compiled
form cause problems if someone is running the build on a bash-less
system? I thought this issue was already raised by Shawn.

I guess we could ignore that issue now, and just say that you have to
build the pre-compiled form on systems with bash?

>
> Then at the runtime:
>
>  (0) If the script notices that it has already learned the command list
>      it uses it; otherwise,
>
>  (1) If the script notices that there is a file that contains the command
>      list, it sources it; otherwise,
>
>  (2) The script lazily builds the command list for its own use.
>
> And at the buildtime, Makefile can run the script in "generation mode",
> and install the output to where (1) above expects to see.

I assume you're suggesting this to ease the upgrade path for users. It
works nicely, we could just install the generated lists in the same path
(contrib/completion/) and then users would be free to copy the two files
anywhere as long as they're in the same directory. The only downside I
see is there's now two files, but that's ok with me.
