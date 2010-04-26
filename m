From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git merge using patience diff?
Date: Mon, 26 Apr 2010 13:59:34 -0500
Message-ID: <20100426185933.GA11518@progeny.tock>
References: <20100426180923.GC18122@debxo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: chombee <chombee@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 20:58:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6TW0-00029m-QG
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab0DZS6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 14:58:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41165 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab0DZS6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:58:41 -0400
Received: by pvg2 with SMTP id 2so575099pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZR12TD2oqBgtMus09/sabNMuQrHIv6A1jXlP0E4oaw8=;
        b=qDBfuhrcqPqiD7nRZHTjGdMvAA8G3wmD65yqAZ24Vtk4avELsJnNhVd5e3UQL440L8
         01+QQSDFkTnaB5Z6sa6Wp+7zlN/iDM3oqSKbNUed5Rf/+g6My2ti60cRftBPVAbod19j
         19B9BLLEfdbXQZqg9BU7LkBzdBupQZSuSaCRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UvKsAzHdKPKoJSBhbM545RRUMje/eT8tRANMgqaKQSDWSLLfvwflzP4NHat6SXldxj
         mQyyZVgIpQg3sg6ZAfnpZnmkHYuRlX38VO2ZoZKFZKiC7cYYzsb2ezKskmzbaWHG3oEl
         iXbrLdtvbbOimBB1rxGEW43bPL0ed3G96jS64=
Received: by 10.140.255.10 with SMTP id c10mr4283707rvi.289.1272308320643;
        Mon, 26 Apr 2010 11:58:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3313897iwn.13.2010.04.26.11.58.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 11:58:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426180923.GC18122@debxo>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145847>

Hi,

chombee wrote:

> My version of git is 1.5.*, from before git diff had the --patience
> option. I got git diff to use bzr's implementation of patience diff v=
ia
> GIT_EXTERNAL_DIFF. But when merging git still seems to use its normal
> diff. Will I need to write my own merge driver that uses patience dif=
f?

You will need to if you want that functionality.  By the way, if you
write a clean patch that adds a git-merge-patience program to git.git
so one can use =E2=80=98git merge -s patience=E2=80=99 out of the box, =
I imagine you
would find some appreciative users.

You could even piggy-back on merge-recursive to do most of the work
(and share a main() function and so on), like merge-subtree did: see
commit 68faf689 (A new merge strategy 'subtree', 2007-02-15) in
git.git.

You might also be interested in the patches at
<http://bugs.debian.org/522361>, which add patience diff support to
git add --patch and friends (and are sitting in limbo until I find
a chance to write some tests for them).

Hope that helps,
Jonathan
