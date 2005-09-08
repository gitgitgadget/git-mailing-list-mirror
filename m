From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [RFC] GIT Repository Annotation Convention
Date: Thu, 08 Sep 2005 12:03:04 -0400
Message-ID: <432060B8.6080408@gmail.com>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 18:05:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDOs0-0004bc-9i
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 18:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVIHQDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVIHQDT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 12:03:19 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:24583 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964882AbVIHQDS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 12:03:18 -0400
Received: by wproxy.gmail.com with SMTP id 57so1336755wri
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 09:03:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cXtllbw6xpnRPsw/ulossvIImtR8474//nqTBWCiCLrQbARhEQw45W+nST5QsFGlMVx0iJZUFKStElsDIYtPSAMTsoH8U0edMZcPxQDT0PZPpx2X43QHYnx9W1+/cT62MJD4ba7Y3aq0aTiiZM77pbiMfPUChn+5691BNpwjiwE=
Received: by 10.54.52.63 with SMTP id z63mr6128076wrz;
        Thu, 08 Sep 2005 09:03:09 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id g7sm625146wra.2005.09.08.09.03.08;
        Thu, 08 Sep 2005 09:03:09 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <431DA8CD.9060009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8202>

GIT Repository Annotation Convention
====================================

GIT repositories can benefit from descriptions of /intent/ for portions
of the repository. This document formalizes a method to store those
descriptions in the repository.

Annotations
------------
Annotations are UTF8 text files. Each text starts with a one line
summary, optionally followed by a blank line and a longer, more detailed
description.

Annotations describe the /intended/ use or contents of the repository
portion described. For instance, a branch is defined by a head ref; the
annotation for that branch would describe what that branch is intended
to hold, how to interpret and/or use the stored state, etc.

Naming and Directory Structure
------------------------------
Annotations are named by appending ".txt" to the basename of the
repository component it describes, and by appending ".dir" to each
directory patch component leading to the repository component from
$GIT_DIR, and by prepending "annotations/" to the annotation pathname.

The use of the ".txt" and ".dir" suffixes is to allow for descriptions
of hierarchical structures (directories) and well as specific components
(files).

Missing annotations are ignored.

The file "$GIT_DIR/description", used by gitweb and other tools, becomes
a symbolic link to "$GIT_DIR/annotations/description.txt".

Example Layout
--------------
$GIT_DIR/
	...
	annotations/
		...
		annotations.txt
		...
		description.txt
		...
		refs.dir/
			...
			heads.dir/
				<head dir 1>.dir/
					<head name 1.1>.txt
					...
					<head name 1.M>.txt
				<head dir 1>.txt
				...
				<head dir N>.dir/
					<head name N.1>.txt
					...
					<head name N.P>.txt
				<head name 1>.txt
				...
				<head name Q>.txt
			...
			tags.dir/
				<tag name 1>.txt
				...
				<tag name T>.txt
			...
	...
	description -> annotations/description.txt
	...

--
