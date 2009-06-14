From: Marco Nelissen <marcone@xs4all.nl>
Subject: Re: running git as root
Date: Sat, 13 Jun 2009 18:41:51 -0700
Message-ID: <3a3d9e520906131841i2e67994fqf323140f95c37d5e@mail.gmail.com>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
	 <81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 03:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFekc-0005VB-4V
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 03:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbZFNBlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 21:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZFNBlv
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 21:41:51 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:54538 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZFNBlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 21:41:51 -0400
Received: by an-out-0708.google.com with SMTP id d40so6547432and.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=XmFV7VureRYRN5QsHNY83aczqDyAfDnrt38BWDPnqQc=;
        b=iJfFmMUMfdUdtQxcEJvWvMVC2Ae4mXTC6DkJcFhrlVUqpXeMvQY4UbDeHHKu+Sn9GD
         FX226l77j0vxZn6n8rn/xXbHLfvr39LNrpM2HO0w4Il7UELqbT3dmE27wLQ9/3ZBRYib
         Qgimrcm2FS1fvn55j0bD2XfQfTOn7AMfILch0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=tquKeW4nJcghb3e2BtZ6zcWbGmKwvRog+4VcNEA9KJ8UJCGxBmlDl1VemhcUMcjHe9
         C5O2/VcFjExPkMB5pTiMMiY4Fo6lhUXyeEMPJDvL26YfJbmFfdnDrinN10yHC6HYqvza
         dKYCRpJoLxnv2bnBwGCLTKXbjC7xCUckcIYDA=
Received: by 10.100.92.16 with SMTP id p16mr4959230anb.136.1244943712793; Sat, 
	13 Jun 2009 18:41:52 -0700 (PDT)
In-Reply-To: <81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
X-Google-Sender-Auth: 18e493d745057dcf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121531>

On Sat, Jun 13, 2009 at 10:49 AM, Alex Riesen<raa.lkml@gmail.com> wrote:
> 2009/6/13 Marco Nelissen <marcone@xs4all.nl>:
>> When running as root, git fails a number of test cases that expect it
>> to fail on read-only repositories (for example 't0004-unwritable.sh').
>> I was thinking of either changing the code so that it checks
>> permissions itself when opening files as root, or add a prerequisite
>> to those test cases so that they are skipped when running as root.
>
> There is such a prerequisite already (POSIXPERM), but what caused
> you to run the _tests_ as root?

POSIXPERM doesn't appear to be quite right for this. For example, the
't1301-shared-repo.sh' test has the POSIXPERM prereq, but it runs fine
as root, because it merely validates that permissions are preserved.
