From: Bram Neijt <bneijt@gmail.com>
Subject: [gitweb feature request] Release snapshots with vX.X.X tags
Date: Sun, 08 Nov 2009 12:40:42 +0100
Message-ID: <1257680442.14087.78.camel@owl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GTaLeNcjZhTl5gv38O2x"
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 12:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N768a-0007bD-OG
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 12:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbZKHLkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZKHLkk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 06:40:40 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57127 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbZKHLkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 06:40:39 -0500
Received: by ewy3 with SMTP id 3so2320405ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 03:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer;
        bh=w46n4X87tL28YnDgbBeGyYYwjZ2m1h5QDkAqpfkvvKk=;
        b=e/IIO0RFsmA6utu0G3lL+bOSOuOKncLKqYNarw2p+R3xry1QnAczPFb7kbA2SCBCU7
         mRo216g1fu+cpr3uc2rvnzm7hl27iflppsmz2nC/9u2xV/lFqLcqPd5Cl7JREjPRYBku
         edW1xxujKCQ1+99tzHscfPF7hZqxLm/GQvh+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer;
        b=CqL+5+8zmThub+Im9oHbXS1akJXupPWfDiFny2yTQ+gMqJqXDIcEA/0h+0s3BLuOoh
         W/+pgAeHG7WBW+2x7wUJ9tKc5J9f9A7P7gUDHVURBIdXyLX6o6YpLMXzu7vh5E2oekF5
         zIkHsEdkylsTDbDGu1oD+KM8VFsgtVs52lmS4=
Received: by 10.213.102.65 with SMTP id f1mr1832047ebo.61.1257680444378;
        Sun, 08 Nov 2009 03:40:44 -0800 (PST)
Received: from ?192.168.1.33? (82-169-1-45.ip.telfort.nl [82.169.1.45])
        by mx.google.com with ESMTPS id 7sm3351337eyb.8.2009.11.08.03.40.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 03:40:43 -0800 (PST)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132393>


--=-GTaLeNcjZhTl5gv38O2x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dear list members,

I would like to create release snapshots with a git tag like "v0.0.1".
For proper Debian packaging, a release snapshot of tag "v0.0.1" would
have to be named "project-0.0.1.tar.gz" and contain a single directory
with "project-0.0.1/" in the archive.

Attached is a very dirty patch to the current head of gitweb.perl to
change the snapshot if the requested hash has a tag which matches
"m/^v(.+)\^0$/". This regular expression will probably have to be more
strict then that in the future, but my main concern is the quality of
the patch, and whether or not this feature is something the mainstream
would appreciate.

My question to you all is: would this feature be considered as an
addition, and if so what would be the best way to get this patch into
shape for inclusion?

Greetings,
  Bram Neijt


--=-GTaLeNcjZhTl5gv38O2x
Content-Disposition: attachment; filename="tag_version_snapshot_detection.patch"
Content-Type: text/x-patch; name="tag_version_snapshot_detection.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

5269a5270,5274
> 	my $tagname = git_get_rev_name_tags($hash);
> 	my $tagversion = "";
> 	if ($tagname =~ m/^v(.+)\^0$/) {
>   	$tagversion = "-" + $1;
> 	}
5275a5281,5288
> 
> 	if($tagversion)	{
> 		$filename .= "$tagversion$known_snapshot_formats{$format}{'suffix'}";
> 	}
> 	else	{
> 		$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
> 	}
> 
5281c5294
< 		"--prefix=$name/", $hash);
---
> 		"--prefix=$name$tagversion/", $hash);

--=-GTaLeNcjZhTl5gv38O2x--
