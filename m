From: Chris Packham <judge.packham@gmail.com>
Subject: Re: New directory lost by git am
Date: Wed, 05 Mar 2014 16:08:57 +1300
Message-ID: <53169549.10309@gmail.com>
References: <531690A3.3040509@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 04:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL2Ci-0000LP-5k
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 04:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbaCEDJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 22:09:03 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45015 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbaCEDJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 22:09:02 -0500
Received: by mail-pb0-f50.google.com with SMTP id md12so453268pbc.9
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 19:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=IkegjBzQKa0LzHBhqkx0V3ZQ7UbDIDLI1bbq5J9PBDE=;
        b=IvtyEd1Eai+1ADXVaBpaHhMsMvaUfuJGGRxf2fm1uWv1P+/ikcHdPvJXDDN6T4Lcb7
         L/85IYv8hqyV2i2cy+Hodz/oTrpDoTTAfFIyi5ySGoF8gw+uOSefKdgANfRAKMSeFsar
         rVtWs4hPzVy+dmUtT2JvhXK6FvuvonOj2auWCnsNcmv27Cv5wJAo8j7chOGnGVTZWi2E
         zqh8RoATH3ZhnTDE52gfg9XnQrGEZnEjBgHbnqiLXDyPXpVZ/9pxf8LOFZPXYRmyZqyN
         ROcfJz06FB/ylREkDD+q+EolpcW4tQaqDB+DwwLoeYW3BmU6/IuRcOPkEv/2xR5W1GGL
         oWfw==
X-Received: by 10.68.49.228 with SMTP id x4mr3863005pbn.50.1393988940978;
        Tue, 04 Mar 2014 19:09:00 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id lh13sm5599394pab.4.2014.03.04.19.08.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 19:09:00 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <531690A3.3040509@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243415>

Hi,

On 05/03/14 15:49, Phillip Susi wrote:
> I applied a patch with git am that adds a new source file to a new
> directory, and later noticed that file was missing from the commit.
> It seems that git am fails to add the new file/directory to the index.
> 

Could you provide a few more details such as your git version (git
--version) and an example of the failure. I've tried to reproduce the
problem based on the description provided but everything seems to work
as expected for me.

  git --version
    git version 1.9.0
  mkdir test && cd test && git init
  echo "hello world" >a.txt
  git add a.txt
  git commit -m"Initial commit"
  git checkout -b temp
  mkdir b
  echo "lorem ipsum" >b/b.txt
  git add b/b.txt
  git commit -m"Add b/b.txt"
  ls -R
    .:
    a.txt  b

    ./b:
    b.txt
  git checkout master
  git format-patch temp -1 --stdout | git am
  ls -R
    .:
    a.txt  b

    ./b:
    b.txt
