From: Thomas Harning <harningt@gmail.com>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:10:27 -0400
Message-ID: <20080313121027.5f51f852@gmail.com>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZq1z-00055C-NV
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYCMQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbYCMQLH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:11:07 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:33783 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYCMQLG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:11:06 -0400
Received: by an-out-0708.google.com with SMTP id d31so832470and.103
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=Pnp6n9VEUkkUqOs6x4adxJ5fCODN+g6fXrGvA+CziUk=;
        b=UPwCAnA58q962e0Skj1ralA691aC24uf3slsB22aLc3dhE8bwQByYOKGbxAfdyRYIRH7maDtyK0x0HkTobUJ687ztpyUAhAMJ/oZfSrebOcnxVdP+3tspvLZA9fRAF7KV9aqPaSw+OHDmbBEPOck+lpWVUzpAHuADfTIZErW5ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Knc+y8nCC0kPRbClGMyQeVb1XVWEdb0hz3AVOKQA4N1iTUfHw1P8CNyH8Ra+5kH11EQ15J7yj1IZuzTClrFRFLlFtv4Xtt1nJAUqYrNRRQ4yX1W1ghgtN7s0W5mV316if+cOlEHLxBUXJPau8EadAhJb9pj8bD83k6v/Gcbsaww=
Received: by 10.100.121.12 with SMTP id t12mr19828297anc.113.1205424665703;
        Thu, 13 Mar 2008 09:11:05 -0700 (PDT)
Received: from localhost ( [149.164.193.61])
        by mx.google.com with ESMTPS id d21sm7979871and.30.2008.03.13.09.11.04
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 09:11:05 -0700 (PDT)
In-Reply-To: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77100>

On Thu, 13 Mar 2008 11:48:53 +0300
"Alexander Gladysh" <agladysh@gmail.com> wrote:

> Hi, list!
> 
> I want to create a private GIT repo (without working copy) on a
> machine in external data-center. While I do not actually believe that
> it is possible that someone who has physical access to a machine would
> be interested in peeking into my repo, I'd like to play safe and to
> have this issue covered.
> 
> Please advise what is the best way to do it. Are there any existing
> solutions?
> 
Potential solution to store arbitrary data in a safe manner:

mkdir remote_git_raw remote_git
sshfs <data-center>:<path @ datacenter> $PWD/remote_git_raw
encfs $PWD/remote_git_raw $PWD/remote_git

This will lock your data in a remote encfs volume.  (Uses FUSE)

Not quite sure about the implications on performance... but this will
certainly keep your data safe on that remote location.
