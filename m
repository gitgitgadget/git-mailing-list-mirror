From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: More git status --porcelain lossage
Date: Sun, 11 Apr 2010 00:28:36 +0200
Message-ID: <4BC0FB94.6050409@gnu.org>
References: <20100409190601.47B37475FEF@snark.thyrsus.com> 	<l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com> 	<m3k4sfgmjc.fsf@localhost.localdomain> <20100410194154.GB28768@thyrsus.com> <s2i46a038f91004101331g1cdca78cya3e125275446a0a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080605070306070202040505"
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jAW-0003Yy-9p
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0DJW2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:28:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:18952 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0DJW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:28:40 -0400
Received: by fg-out-1718.google.com with SMTP id 22so61552fge.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type;
        bh=VkUMoJG13SwwB5ea8sYhzIyPzIm64iUmR+S+wB1PnDs=;
        b=HgeMz8AYn1OaXfmMFHpvEvbfEh8zryEGrC5V5KQ+txL2yEwlBtXTw4He8pcRfUds2o
         FPdug+SiXIi5Uo33PICpwLeAlkK2qR4VZQ5IKLhv2PxBF4dOZmZiNY1kg8nF26eZz3lo
         gDjaTukHVd9BzstUMqPmNNl8yZvVzUaAreMyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        b=KbW1hH0cd+qjZBeioGOEQP5zlAyDx9qirahw67Ry7wQsMjS+Wj5zHU6kHWEmK6xixG
         amBijTn2xfRDutRj5wFxcYscOz9qWQ88MENo95nWzeeR+4vMem48mDhB0scWKji8kTQI
         n9zKg/ZGnO4y56N1HE+aFmhFhuK8OSv9qbs4c=
Received: by 10.223.15.143 with SMTP id k15mr1664090faa.57.1270938518567;
        Sat, 10 Apr 2010 15:28:38 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id z10sm5807844fka.1.2010.04.10.15.28.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 15:28:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <s2i46a038f91004101331g1cdca78cya3e125275446a0a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144603>

This is a multi-part message in MIME format.
--------------080605070306070202040505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2010 10:31 PM, Martin Langhoff wrote:
> On Sat, Apr 10, 2010 at 3:41 PM, Eric Raymond<esr@thyrsus.com>  wrote:
>>> I could understand providing JSON format, specified using --json
>>> option.
>>
>> You know, that's actually an interesting idea.  I mentioned it
>> previously as the not-XML if we want to build on a metaprotocol;
>
> One issue is that there's no stream-parser JSON implementations that
> I'm aware of.

Here is one.  It's ugly as hell, you're warned.  The only missing piece 
is making the stack state resizable.

Paolo

--------------080605070306070202040505
Content-Type: text/plain;
 name="json.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="json.c"

/*
 * An event-based, asynchronous JSON parser.
 *
 * Copyright (C) 2009 Red Hat Inc.
 *
 * Authors:
 *  Paolo Bonzini <pbonzini@redhat.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#include "json.h"
#include <string.h>
#include <stdlib.h>

/* Common character classes.  */

#define CASE_XDIGIT \
        case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': \
        case 'A': case 'B': case 'C': case 'D': case 'E': case 'F'

#define CASE_DIGIT \
        case '0': case '1': case '2': case '3': case '4': \
        case '5': case '6': case '7': case '8': case '9'

/* Helper function to go from \uXXXX-encoded UTF-16 to UTF-8.  */

static bool hex_to_utf8 (char *buf, char **dest, char *src)
{
    int i, n;
    uint8_t *p;

    for (i = n = 0; i < 4; i++) {
        n <<= 4;
        switch (src[i])
        {
        CASE_DIGIT: n |= src[i] - '0'; break;
        CASE_XDIGIT: n |= (src[i] & ~32) - 'A' + 10; break;
        default: return false;
        }
    }

    p = (uint8_t *)*dest;
    if (n < 128) {
        *p++ = n;
    } else if (n < 2048) {
        *p++ = 0xC0 | (n >> 6);
        *p++ = 0x80 | (n & 63);
    } else if (n < 0xDC00 || n > 0xDFFF) {
        *p++ = 0xE0 | (n >> 12);
        *p++ = 0x80 | ((n >> 6) & 63);
        *p++ = 0x80 | (n & 63);
    } else {
        /* Merge with preceding high surrogate.  */
        if (p - (uint8_t *)buf < 3
            || p[-3] != 0xED
            || p[-2] < 0xA0 || p[-2] > 0xAF) /* 0xD800..0xDBFF */
            return false;

        n += 0x10000 - 0xDC00;
        n += ((p[-2] & 15) << 16) | ((p[-1] & 63) << 10);

        /* Overwrite high surrogate.  */
        p[-3] = 0xF0 | (n >> 18);
        p[-2] = 0x80 | ((n >> 12) & 63);
        p[-1] = 0x80 | ((n >> 6) & 63);
        *p++ = 0x80 | (n & 63);
    }
    *dest = (char *)p;
    return true;
}

struct json_parser {
    struct    json_parser_config c;
    size_t    n, alloc;
    char      *buf;
    size_t    sp;
    uint32_t  state, stack[128];
    char      start_buffer[128];
};

/* Managing the state stack.  */

static inline void push_state (struct json_parser *p, uint32_t state)
{
    p->stack[p->sp++] = p->state;
    p->state = state;
}

static inline void pop_state (struct json_parser *p)
{
    p->state = p->stack[--p->sp];
}


/* Managing the string/number buffer.  */

static inline void clear_buffer (struct json_parser *p)
{
    p->n = 0;
}

static inline void push_buffer (struct json_parser *p, char c)
{
    if (p->n == p->alloc) {
        size_t new_alloc = p->alloc * 2;
        if (p->buf == p->start_buffer) {
            p->buf = malloc (new_alloc);
            memcpy (p->buf, p->start_buffer, p->alloc);
        } else {
            p->buf = realloc (p->buf, new_alloc);
        }
        p->alloc = new_alloc;
    }
    p->buf[p->n++] = c;
}


/*
 * Parser states are organized like this:
 *   bit 0-7:   enum parser_state
 *   bit 8-15:  for IN_KEYWORD, index in keyword table
 *   bit 16-31: additional substate (enum parser_cookies)
 */

enum parser_state {
    START_PARSE,                /* at start of parsing */
    IN_KEYWORD,                 /* parsing keyword (match exactly) */
    START_KEY,                  /* expecting key */
    END_KEY,                    /* expecting colon */
    START_VALUE,                /* expecting value */
    END_VALUE,                  /* expecting comma or closing parenthesis */
    IN_NUMBER,                  /* parsing number (up to whitespace) */
    IN_STRING,                  /* parsing string */
    IN_STRING_BACKSLASH,        /* parsing string, copy one char verbatim */
    IN_COMMENT,                 /* comment mini-scanner */
};

enum parser_cookies {
    IN_UNUSED,

    IN_TRUE,                    /* for IN_KEYWORD */
    IN_FALSE,
    IN_NULL,

    IN_ARRAY,                   /* for {START,END}_{KEY,VALUE} */
    IN_DICT,

    IN_KEY,                     /* for IN_STRING */
    IN_VALUE,
};

#define STATE(state, cookie) \
    (((cookie) << 16) | (state))

#define STATE_KEYWORD(n, cookie) \
    (((cookie) << 16) | ((n) << 8) | IN_KEYWORD)

static const char keyword_table[] = "rue\0alse\0ull";
enum keyword_indices {
    KW_TRUE = 0,
    KW_FALSE = 4,
    KW_NULL = 9,
};



/* Parser actions.  These transfer to the appropriate state,
 * and invoke the callbacks.
 *
 * If there is a begin/end pair, begin pushes a state
 * and end pops it.
 */

static inline bool array_begin (struct json_parser *p)
{
    push_state (p, STATE (START_VALUE, IN_ARRAY));
    return !p->c.array_begin || p->c.array_begin (p->c.data);
}

static inline bool array_end (struct json_parser *p)
{
    int state_cookie = (p->state >> 16);
    if (state_cookie != IN_ARRAY) return false;
    pop_state (p);
    return !p->c.array_end || p->c.array_end (p->c.data);
}


static inline bool object_begin (struct json_parser *p)
{
    push_state (p, STATE (START_KEY, IN_DICT));
    return !p->c.object_begin || p->c.object_begin (p->c.data);
}

static inline bool object_end (struct json_parser *p)
{
    int state_cookie = (p->state >> 16);
    if (state_cookie != IN_DICT) return false;
    pop_state (p);
    return !p->c.object_end || p->c.object_end (p->c.data);
}


static inline bool key_user (struct json_parser *p)
{
    return p->c.value_user && p->c.key (p->c.data, NULL, 0);
}


static inline bool number_begin (struct json_parser *p, char ch)
{
    push_state (p, IN_NUMBER);
    push_buffer (p, ch);
    return true;
}

static inline bool number_end (struct json_parser *p)
{
    char *end;
    bool result;
    long long ll;
    double d;

    pop_state (p);
    push_buffer (p, 0);
    ll = strtoll (p->buf, &end, 0);
    if (!*end)
        result = (!p->c.value_integer || p->c.value_integer (p->c.data, ll));
    else {
        d = strtod (p->buf, &end);
        result = (!*end &&
                  (!p->c.value_float || p->c.value_float (p->c.data, d)));
    }

    clear_buffer(p);
    return result;
}


static inline bool value_null (struct json_parser *p)
{
    return !p->c.value_null || p->c.value_null (p->c.data);
}


static inline bool value_boolean (struct json_parser *p, int n)
{
    return !p->c.value_boolean || p->c.value_boolean (p->c.data, n);
}


static inline bool string_begin (struct json_parser *p, int cookie)
{
    push_state (p, STATE (IN_STRING, cookie));
    return true;
}

static inline bool string_end (struct json_parser *p, int cookie)
{
    bool result;
    char *buf, *src, *dest;
    size_t n;

    pop_state (p); 
    push_buffer (p, 0);

    /* Unescape in place.  */
    for (n = p->n, buf = src = dest = p->buf; n > 0; n--) {
        if (*src != '\\') {
            *dest++ = *src++;
            continue;
        }
        if (n < 2)
            return false;

        src++;
        n--;
        switch (*src++) {
        case 'b': *dest++ = '\b'; continue;
        case 'f': *dest++ = '\f'; continue;
        case 'n': *dest++ = '\n'; continue;
        case 'r': *dest++ = '\r'; continue;
        case 't': *dest++ = '\t'; continue;

        case 'U': case 'u': 
            /* The [uU] has not been removed from n yet, hence subtract 5.  */
            if (n < 5 || !hex_to_utf8 (buf, &dest, src))
                return false;
            src += 4;
            n -= 4;
            continue;

        default: *dest++ = src[-1]; continue;
        }
    }

    buf = p->buf;
    n = dest - buf;
    if (cookie == IN_KEY)
        result = !p->c.key || p->c.key (p->c.data, buf, n);
    else
        result = !p->c.value_string || p->c.value_string (p->c.data, buf, n);
    clear_buffer(p);
    return result;
}


static inline bool value_user (struct json_parser *p)
{
    return p->c.value_user && p->c.value_user (p->c.data);
}


static inline bool comment (struct json_parser *p)
{
    return !p->c.comment || p->c.comment (p->c.data, p->buf, p->n);
}


bool json_parser_char(struct json_parser *p, char ch)
{
    for (;;) {
        int state = p->state & 255;
        int state_data = (p->state >> 8) & 255;
        int state_cookie = (p->state >> 16);
        // printf ("%d %d | %d %d\n", state, ch, state_cookie, p->sp);

        /* The big ugly parser.  Each case will always return or
         * continue, and we want to check this at link time if
         * possible.  */
#ifndef __OPTIMIZE__
#define link_error abort
#endif
        extern void link_error (void);

        switch (state)
        {
        /* First, however, a helpful definition...  */
#define SKIP_WHITE \
            switch (ch) { \
            case '/': goto do_start_comment; \
            case ' ': case '\t': case '\n': case '\r': case '\f': return true; \
            default: break; \
            }

        /* Unlike START_VALUE, this only accepts compound values.  */
        case START_PARSE:
            SKIP_WHITE;
            p->state = STATE (END_VALUE, state_cookie); 
            switch (ch)
            {
            case '[': return array_begin (p);
            case '{': return object_begin (p);
            default: return false;
            }
            link_error ();

        /* Only strings and user values are accepted here.  */
        case START_KEY:
            SKIP_WHITE;
            p->state = STATE (END_KEY, IN_DICT);
            switch (ch)
            {
            case '"': return string_begin (p, IN_KEY);
            case '%': return key_user (p);
            case '}': return object_end (p);
            default: return false;
            }
            link_error ();

        /* Accept any Javascript literal.  Checking p->sp ensures that
         * something like "[] []" is rejected (the first array is parsed
         * from START_PARSE.  */
        case START_VALUE:
            SKIP_WHITE;
            if (p->sp == 0)
                return false;
            p->state = STATE (END_VALUE, state_cookie); 
            switch (ch)
            {
            case 't': push_state (p, STATE_KEYWORD(KW_TRUE, IN_TRUE)); return true;
            case 'f': push_state (p, STATE_KEYWORD(KW_FALSE, IN_FALSE)); return true;
            case 'n': push_state (p, STATE_KEYWORD(KW_NULL, IN_NULL)); return true;
            case '"': return string_begin (p, IN_VALUE);
            case '-':
            CASE_DIGIT: return number_begin (p, ch);
            case '[': return array_begin (p);
            case '{': return object_begin (p);
            case '%': return value_user (p);
            case ']': return array_end (p);
            default: return false;
            }
            link_error ();

        /* End of a key, look for a colon.  */
        case END_KEY:
            SKIP_WHITE;
            p->state = STATE (START_VALUE, IN_DICT);
            return (ch == ':');

        /* End of a value, look for a comma or closing parenthesis.  */
        case END_VALUE:
            SKIP_WHITE;
            p->state = STATE (state_cookie == IN_DICT ? START_KEY : START_VALUE,
                              state_cookie);
            switch (ch)
            {
            case ',': return true;
            case '}': return object_end (p);
            case ']': return array_end (p);
            default: return false;
            }
            link_error ();

        /* Table-driven keyword scanner.  Advance until mismatch or end
         * of keyword.  */
        case IN_KEYWORD:
            if (ch != keyword_table[state_data])
                return false;
            if (keyword_table[state_data + 1] != 0) {
                p->state = STATE_KEYWORD(state_data + 1, state_cookie);
                return true;
            }

            pop_state (p);
            switch (state_cookie) {
            case IN_TRUE: return value_boolean (p, 1);
            case IN_FALSE: return value_boolean (p, 0);
            case IN_NULL: return value_null (p);
            default: abort ();
            }
            link_error ();

        /* Eat until closing quote (special-casing \"). */
        case IN_STRING:
            switch (ch) {
            case '"': return string_end (p, state_cookie);
            case '\\': p->state = STATE (IN_STRING_BACKSLASH, state_cookie);
            default: push_buffer (p, ch); return true;
            }
            link_error ();

        /* Eat any character */
        case IN_STRING_BACKSLASH:
            push_buffer (p, ch); 
            p->state = STATE (IN_STRING, state_cookie);
            return true;

        /* Eat until a "bad" character is found, then we refine with
         * strtod/strtoll.  The character we end on is reprocessed in
         * the new state!  */
        case IN_NUMBER:
            switch (ch) {
            case '+':
            case '-':
            case '.':
            case 'x':
            case 'X':
            CASE_DIGIT:
            CASE_XDIGIT: push_buffer (p, ch); return true;
            default: if (!number_end (p)) return false; continue;
            }
            link_error ();

        /* Parse until '*' '/', then convert the whole comment to a
         * single blank and rescan. */
        do_start_comment:
            push_state(p, IN_COMMENT);
            if (p->c.comment) push_buffer(p, ch);
            return true;

        case IN_COMMENT:
            if (p->c.comment) push_buffer(p, ch);

            if      (state_cookie == 0 && ch != '*') return false;
            else if (state_cookie == 0             ) state_cookie = 1;
            else if (state_cookie == 1 && ch == '*') state_cookie = 2;
            else if (state_cookie == 2 && ch == '*') state_cookie = 2;
            else if (state_cookie == 2 && ch == '/') state_cookie = 3;
            else                                     state_cookie = 1;

            if (state_cookie < 3) {
                p->state = STATE(state, state_cookie);
                return true;
            } else {
                comment (p);
                pop_state (p);
                ch = ' ';
                continue;
            }
            link_error ();

        default:
            abort ();
        }

        link_error ();
    }
}

bool json_parser_string(struct json_parser *p, char *s, size_t n)
{
    while (n--)
        if (!json_parser_char(p, *s++))
            return false;
    return true;
}

struct json_parser *json_parser_new(struct json_parser_config *config)
{
    struct json_parser *p;
    p = malloc (sizeof *p);
    memcpy (&p->c, config, sizeof *config);
    p->n = 0;
    p->alloc = sizeof p->start_buffer;
    p->state = START_PARSE;
    p->buf = p->start_buffer;
    p->sp = 0;
    return p;
}

bool json_parser_destroy(struct json_parser *p)
{
    bool result = (p->state == END_VALUE) && (p->sp == 0);
    if (p->buf != p->start_buffer)
        free (p->buf);
    free (p);
    return result;
}

--------------080605070306070202040505
Content-Type: text/plain;
 name="main.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="main.c"

/* main.c */

/*
    This program demonstrates a simple application of JSON_parser. It reads
    a JSON text from STDIN, producing an error message if the text is rejected.

        % JSON_parser <test/pass1.json
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <locale.h>

#include "json.h"

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

static int level = 0;
static int got_key = 0;

static void print_indent()
{
    printf ("%*s", 2 * level, "");
}
 
static bool array_begin (void *data)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("[\n");
    ++level;
    return true;
}

static bool array_end (void *data)
{
    --level;
    print_indent ();
    printf ("]\n");
    return true;
}

static bool object_begin (void *data)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("{\n");
    ++level;
    return true;
}

static bool object_end (void *data)
{
    --level;
    print_indent ();
    printf ("}\n");
    return true;
}

static bool key (void *data, const char *buf, size_t n)
{
    got_key = 1;
    print_indent ();
    if (buf)
	printf ("key = '%s', value = ", buf);
    else
	printf ("user key = %%%c, value = ", getchar());
    return true;
}

static bool value_integer (void *data, long long ll)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("integer: %lld\n", ll);
    return true;
}

static bool value_float (void *data, double d)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("float: %f\n", d);
    return true;
}

static bool value_null (void *data)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("null\n");
    return true;
}

static bool value_boolean (void *data, int val)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("%s\n", val ? "true" : "false");
    return true;
}

static bool value_string (void *data, const char *buf, size_t n)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("string: '%s'\n", buf);
    return true;
}

static bool value_user (void *data)
{
    if (!got_key) print_indent(); else got_key = 0;
    printf ("user: %%%c\n", getchar());
    return true;
}



int main(int argc, char* argv[]) {
    static struct json_parser_config parser_config = {
        .array_begin = array_begin,
        .array_end = array_end,
        .object_begin = object_begin,
        .object_end = object_end,
        .key = key,
        .value_integer = value_integer,
        .value_float = value_float,
        .value_null = value_null,
        .value_boolean = value_boolean,
        .value_string = value_string,
        .value_user = value_user,
    };

    struct json_parser *p = json_parser_new(&parser_config);
    int count = 0;
    int ch;
    while ((ch = getchar ()) != EOF && json_parser_char (p, ch))
	count++;

    if (ch != EOF) {
	fprintf (stderr, "error at character %d\n", count);
	exit (1);
    }
    if (!json_parser_destroy (p)) {
	fprintf (stderr, "error at end of file\n");
	exit (1);
    }

    exit (0);
}

--------------080605070306070202040505
Content-Type: text/plain;
 name="json.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="json.h"

/*
 * An event-based, asynchronous JSON parser.
 *
 * Copyright (C) 2009 Red Hat Inc.
 *
 * Authors:
 *  Paolo Bonzini <pbonzini@redhat.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#ifndef JSON_H
#define JSON_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

struct json_parser_config {
    bool (*array_begin) (void *);
    bool (*array_end) (void *);
    bool (*object_begin) (void *);
    bool (*object_end) (void *);
    bool (*key) (void *, const char *, size_t);
    bool (*value_integer) (void *, long long);
    bool (*value_float) (void *, double);
    bool (*value_null) (void *);
    bool (*value_boolean) (void *, int);
    bool (*value_string) (void *, const char *, size_t);
    bool (*value_user) (void *);
    bool (*comment) (void *, const char *, size_t);
    void *data;
};

struct json_parser;

struct json_parser *json_parser_new(struct json_parser_config *config);
bool json_parser_destroy(struct json_parser *p);
bool json_parser_char(struct json_parser *p, char ch);
bool json_parser_string(struct json_parser *p, char *buf, size_t n);

#endif /* JSON_H */


--------------080605070306070202040505--
