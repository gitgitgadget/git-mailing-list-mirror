From: Kristian Freed <kristian.freed@gmail.com>
Subject: What is the best way to perform a complex refactoring spanning
 multiple repositories?
Date: Fri, 26 Jul 2013 11:56:44 +0100
Message-ID: <CAFw3YtRyTAehOWpRkpwLWUjOFC6eB7Mk6=r_RGcjREGGHNafKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 26 12:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2fhv-0000Cc-Us
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 12:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab3GZK5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 06:57:08 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35480 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab3GZK5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 06:57:06 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so651167wgh.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=L9nq510TiHq1yL69vxPocstmX4pflmIQuKNjWKl8n94=;
        b=MlfhHz72r9XI0nycl+WOUOFD6C0TFgDmNUaaU67AApT3o7GL5K8mt1/Mpn21vQWiHS
         CxvtQAbGuoaKCOCg/JZZgaeqwM7b7J2NQDV0cZ6lM1Pe491VGcQESYDdV7bn5vR3y+ET
         4T/EWuoRvaTeY7b1ulCDpcxlkK8IRAF+avoHGkYX7SVxhwQcyNaeCx6WdBfBNgE0+PJx
         R480/4mv33iKdB+26AfOZEC5pQyDO427XYOFZlRS4Eyd6f7fb0kThq+O/hdPzRaiFyDS
         Lz0ESj8GW8BS+R7KDK0wBdr5G110+0b64x/IcLaqO9RRZjdO5FjcxEoCRLdelx8R5F4v
         VTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=L9nq510TiHq1yL69vxPocstmX4pflmIQuKNjWKl8n94=;
        b=aWyD9l83xaKN5BHFRj63wHjvRSh/2guwUOgapK+vOzciz7WXlFvRO4GpaOEPXMkMZo
         PFMh69jAj4n7gNUG2SrKgctXO1C/2d73uCgUB3tDcCgk2vT5yi18VPcmgzOYh2nBkKT+
         FaFEcnNre61SS1bA9aWnOKCDEGIndJZBGhJ7+bejZHckJb1yCCnSh1i4aL2f90xhdjYj
         jlL2yPejCLGgZS/CFa73AmGBOVftgdXwGIJJ0g0VTKZCjwa0iXBzFD539dY8Drx5OdaO
         tWnrawjPfiSd4bEdx1YMm0ET1gOBiZQ7j4anEQrewV7fSCXNfgf8ttWb6nTMOb/io4b2
         t3/Q==
X-Received: by 10.180.78.137 with SMTP id b9mr5259834wix.16.1374836224636;
 Fri, 26 Jul 2013 03:57:04 -0700 (PDT)
Received: by 10.194.77.11 with HTTP; Fri, 26 Jul 2013 03:56:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231179>

Hi,

I need to re-organize a project using git. This project currently has
3 separate (central) repositories and I will need to move a large
number of files back and forth between them. While doing this, there
is development going on on each branch, and the restructuring will
take some time. I have been continuously rebasing my refactor branches
from master in each respective repository.

Is there an established way of doing this sort of complex cross
repository refactoring in a way that preserves the history across
repositories and takes advantage of git's rename merge logic across
repositories, by say moving all repos into a third one, do the merge
and move back?

Effectively, I have three repositories, A, B, and C. I want to move
files from B to A and C and preserve history. This is not a simple
move of one directory, but a large number of individual files being
moved to new locations, renamed, updated etc. I have been working
across A, B, and C, moving and updating files, but this will obviously
not keep the history of the files being moved across repositories. I
imagine that it would be possible to create a new repository D, import
A, B, and C into sub directories, rebase to merge the individual
commits on A, B, and C into one new big commit on D that will make git
understand that files have been moved across, not just removed in one
place and deleted from another, then apply the changes back to each
individual repository?

Thanks,
Kristian
