From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] compressed import v3
Date: Sat, 14 Jun 2008 12:26:46 +0200
Message-ID: <20080614102646.GD14282@diana.vm.bytemark.co.uk>
References: <48519602.2090103@gmail.com> <20080613051127.GA24245@diana.vm.bytemark.co.uk> <485289FD.50808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 12:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SzJ-0006x6-A3
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 12:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYFNK1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 06:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbYFNK1H
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 06:27:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2832 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbYFNK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 06:26:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K7Sy6-00045G-00; Sat, 14 Jun 2008 11:26:46 +0100
Content-Disposition: inline
In-Reply-To: <485289FD.50808@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85008>

On 2008-06-13 09:53:49 -0500, Clark Williams wrote:

> I'm interested to hear how you'd condense the code in
> __gethandleandname().

Like this, for example:

    import bz2, gzip
    for copen, ext in [(gzip.open, '.gz'), (bz2.BZ2File, '.bz2')]:
        try:
            f =3D copen(filename)
            f.read(1)
            f.seek(0)
            return (f, __mkpatchname(filename, ext))
        except IOError, e:
            pass

If you don't mind, I'll just fix that up directly in your patch. (I
also took the liberty to rename the function to __get_handle_and_name,
since that's more consistent with other functions in that file.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
